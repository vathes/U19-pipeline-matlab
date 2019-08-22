import datajoint as dj
from . import subject, lab, task, reference, acquisition
from ScanImageTiffReader import ScanImageTiffReader
import scanreader
from os import path
import glob
import re
from datetime import datetime
import scipy.io as sio
import numpy as np

schema = dj.schema(dj.config['database.prefix'] + 'acquisition')


@schema
class Session(dj.Manual):
    definition = """
    -> subject.Subject
    session_date:               date        # date of experiment
    session_number:             int     	# number
    ---
    session_start_time:         datetime    # start time
    session_end_time=null:      datetime	# end time
    -> lab.Location
    -> lab.User
    -> task.TaskLevelParameterSet
    stimulus_bank:             varchar(255)           # path to the function to generate the stimulus
    stimulus_commit='':        varchar(64)            # git hash for the version of the function
    stimulus_set:              tinyint                # an integer that describes a particular set of stimuli in a trial
    ball_squal:                float                  # quality measure of ball data
    session_performance:       float                  # percentage correct on this session
    session_narrative='':      varchar(512)
    """


@schema
class SessionType(dj.Lookup):
    definition = """
    session_type:   varchar(32)
    """
    contents = zip([
        'Training', 'Imaging', 'Optogenetics', 'Ephys'
    ])


@schema
class SessionSessionType(dj.Manual):
    definition = """
    -> Session
    -> SessionType
    """


@schema
class Scan(dj.Imported):
    definition = """
    -> Session
    ---
    scan_directory:     varchar(255)
    gdd=null:           float
    wavelength=920:     float           # in nm
    pmt_gain=null:      float
    -> [nullable]reference.BrainArea.proj(imaging_area='brain_area')
    frame_time:         longblob
    """
    def make(self, key):
        ### for test
        key_copy = key.copy()
        ### end of test

        scan = key.copy()
        user, subj, session_date = (acquisition.Session & key).fetch1(
            'user_id', 'subject_id', 'session_date')

        session_date = str(session_date).replace('-', '')

        base_dir = lab.Path().get_local_path('/bezos/RigData/scope/bay3/')
        dir_pattern = path.join(base_dir, user, '*', 'imaging', subj, session_date)
        dirs = glob.glob(dir_pattern)

        if not len(dirs):
            return
        else:
            scan['scan_directory'] = dirs[0]
            file_pattern = path.join(dirs[0], '*.tif')
            files = glob.glob(file_pattern)

            if not len(files):
                return
            else:
                scan_dir = scan['scan_directory']
                ### for test
                scan_dir = '/Users/shanshen/Documents/princeton_imaging_data/20170203/'
                key_copy['subject_id'] = 'E22'
                key_copy['session_date'] = datetime.date(2017, 2, 3)
                ### end of test

                meta_pattern = key_copy['subject_id'] + '_' + str(key_copy['session_date']).replace('-', '') + '*meta.mat'
                file_name_pattern = path.join(scan_dir, meta_pattern)
                f = glob.glob(file_name_pattern)
                meta_data = sio.loadmat(f[0], struct_as_record=False, squeeze_me=True)
                scan['frame_time'] = np.hstack([item.frameTime for item in meta_data['imaging']])
                self.insert1(scan)

                for ifile in files:
                    file_tuple = key.copy()
                    file_name = re.search('{}_{}.*tif'.format(subj, session_date), ifile).group(0)
                    temp = re.search('0{1,5}[0-9][0-9].tif', ifile).group(0)
                    file_number = int(temp.replace('.tif', ''))
                    file_tuple['file_number'] = file_number
                    file_tuple['scan_filename'] = file_name
                    self.File.insert1(file_tuple)

    class File(dj.Part):
        definition = """
        -> master
        file_number:    int             # file number of a given scan
        ---
        scan_filename:  varchar(255)
        """


@schema
class ScanInfo(dj.Imported):
    definition = """
    # scan meta information from the tiff file
    -> Scan
    ---
    nfields=1               : tinyint           # number of fields
    nchannels               : tinyint           # number of channels
    nframes                 : int               # number of recorded frames
    nframes_requested       : int               # number of requested frames (from header)
    px_height               : smallint          # lines per frame
    px_width                : smallint          # pixels per line
    um_height=null          : float             # height in microns
    um_width=null           : float             # width in microns
    x=null                  : float             # (um) center of scan in the motor coordinate system
    y=null                  : float             # (um) center of scan in the motor coordinate system
    fps                     : float             # (Hz) frames per second
    zoom                    : decimal(5,2)      # zoom factor
    bidirectional           : boolean           # true = bidirectional scanning
    usecs_per_line          : float             # microseconds per scan line
    fill_fraction_temp      : float             # raster scan temporal fill fraction (see scanimage)
    fill_fraction_space     : float             # raster scan spatial fill fraction (see scanimage)
    """

    def make(self, key):
        # get the first file of the scan
        file_dir = (Scan & key).fetch1('scan_directory')
        file1 = (Scan.File & key & 'file_number=1').fetch1('scan_filename')

        filepath = path.join(file_dir, file1)
        filepath = '/Users/shanshen/Documents/princeton_imaging_data/20170203/E22_20170203_30per_00001_00015.tif'
        t = ScanImageTiffReader(filepath)
        t2 = scanreader.read_scan(filepath)

        s = repr(t.description(0))
        fields = s.split('\\')

        fields_dict = dict()
        for field in fields:
            f = field.replace('"', '')
            if re.search(' = ', f):
                statement = re.split(' = ', f)
                fields_dict[statement[0]] = statement[1]

        # number of channels
        f = fields_dict['nscanimage.SI.hChannels.channelsActive']
        channels= f.replace('[', '').replace(']', '').split('\'')
        key['nchannels'] = len(channels)

        # number of frames
        key.update(
            nframes=int(fields_dict['nframeNumberAcquisition']),
            nframes_requested=int(fields_dict['nframeNumberAcquisition']),
            px_height=t2.image_height,
            px_width=t2.image_width,
            fps=t2.fps,
            zoom=t2.zoom,
            bidirectional=t2.is_bidirectional,
            usecs_per_line=t2.seconds_per_line*1e6,
            fill_fraction_temp=t2.temporal_fill_fraction,
            fill_fraction_space=t2.spatial_fill_fraction
        )

        self.insert1(key)
