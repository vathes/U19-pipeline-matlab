import datajoint as dj
from . import subject, lab, task, reference

schema = dj.schema('pni_acquisition')


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
    scan_filename:      varchar(64)
    gdd=null:           float
    wavelength=920:     float
    pmt_gain=null:      float
    -> reference.BrainArea.proj(imaging_area='brain_area')
    # Plus the meta data from scan image .tiff file
    """



@schema
class DataDirectory(dj.Computed):
    definition = """
    -> Session
    ---
    data_dir:  varchar(255) # data directory for each session
    file_name: varchar(255) # file name
    combined_file_name: varchar(255) # combined filename
    """
