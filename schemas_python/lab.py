import datajoint as dj
import sys
import os
import numpy as np

schema = dj.schema('pni_lab')


@schema
class Lab(dj.Lookup):
    definition = """
    lab:                    varchar(16)  # name of lab
    -----
    institution:            varchar(64)
    address:                varchar(128)
    time_zone:              varchar(32)
    """
    contents = [
        ['tanklab', 'Princeton', 'Princeton Neuroscience Institute, \
            Princeton University Princeton, NJ 08544', 'America/New_York'],
        ['wittenlab', 'Princeton', 'Princeton Neuroscience Institute, \
            Princeton University Princeton, NJ 08544', 'America/New_York']
    ]


@schema
class Location(dj.Lookup):
    definition = """
    # The physical location at which an session is performed or appliances
    # are located. This could be a room, a rig or a bench.
    location:                   varchar(32)
    -----
    location_description='':    varchar(255)
    """
    contents = [
        ['Benzos2', ''],
        ['Benzos3',  ''],
        ['vivarium', ''],
        ['pni-171jppw32', ''],
        ['pni-174cr4jk2', ''],
        ['valhalla', '']
    ]


@schema
class Project(dj.Lookup):
    definition = """
    project:                    varchar(64)
    -----
    project_description='':     varchar(255)
    """
    contents = [
        ['behavioral task', ''],
        ['accumulation of evidence', '']
    ]


@schema
class User(dj.Manual):
    definition = """
    user_id:                varchar(32)     # username
    -----
    full_name=null:         varchar(32)     # first name
    email=null:		        varchar(64)     # email address
    phone=null:             varchar(12)     # phone number
    carrier=null:           varchar(16)     # phone carrier
    slack=null:             varchar(32)     # slack username
    contact_via:            enum('Slack', 'text', 'Email')
    presence:		        enum('Available', 'Away')
    primary_tech='N/A':     enum('yes', 'no', 'N/A')
    tech_responsibility='N/A':    enum('yes', 'no', 'N/A')
    day_cutoff_time:        blob
    slack_webhook=null:     varchar(255)
    watering_logs=null:     varchar(255)
    """


@schema
class UserLab(dj.Manual):
    definition = """
    -> User
    -----
    -> Lab
    """


@schema
class ProjectUser(dj.Manual):
    definition = """
    -> Project
    -> User
    """


@schema
class Protocol(dj.Lookup):
    definition = """
    protocol: varchar(16)                     # protocol number
    ---
    reference_weight_pct=null:   float        # percentage of initial allowed
    protocol_description='':     varchar(255) # description
    """
    contents = [
        ['1910', 0.8, 'Tank Lab protocol']
    ]


@schema
class UserProtocol(dj.Lookup):
    definition = """
    -> User
    -> Protocol
    """


@schema
class Path(dj.Lookup):
    definition = """
    global              : varchar(255)               # global path name
    system              : enum('windows', 'mac', 'linux')
    ---
    local_path          : varchar(255)               # local computer path
    net_location        : varchar(255)               # location on the network
    description=null    : varchar(255)
    """

    contents = [
        ['/bezos', 'windows', 'Y:', r'\\bucket.pni.princeton.edu\Bezos-center', ''],
        ['/bezos', 'mac', '/Volumes/bezos', 'apps.pni.princeton.edu:/jukebox/Bezos', ''],
        ['/bezos', 'linux', '/mnt/bezos', 'apps.pni.princeton.edu:/jukebox/Bezos', ''],
        ['/braininit', 'windows', 'Z:', r'\\bucket.pni.princeton.edu\braininit', ''],
        ['/braininit', 'mac', '/Volumes/braininit', 'apps.pni.princeton.edu:/jukebox/braininit', ''],
        ['/braininit', 'linux', '/mnt/bezos', 'apps.pni.princeton.edu:/jukebox/braininit', '']
    ]

    def get_local_path(self, path, local_os=None):

        # determine local os
        if local_os is None:
            local_os = sys.platform
            local_os = local_os[:(min(3, len(local_os)))]
        if local_os.lower() == 'glo':
            local = 0
            home = '~'

        elif local_os.lower() == 'lin':
            local = 1
            home = os.environ['HOME']

        elif local_os.lower() == 'win':
            local = 2
            home = os.environ['HOME']

        elif local_os.lower() == 'dar':
            local = 3
            home = '~'

        else:
            raise NameError('unknown OS')

        path = path.replace(os.path.sep, '/')
        path = path.replace('~', home)

        globs = dj.U('global') & self
        systems = ['linux', 'windows', 'mac']

        mapping = [[], []]

        for iglob, glob in enumerate(globs.fetch('KEY')):
            mapping[iglob].append(glob['global'])
            for system in systems:
                mapping[iglob].append((self & glob & {'system': system}).fetch1('local_path'))

        mapping = np.asarray(mapping)

        for i in range(len(globs)):
            for j in range(len(systems)):
                n = len(mapping[i, j])
                if j != local and path[:n] == mapping[i, j][:n]:
                    path = os.path.join(mapping[i, local], path[n+1:])
                    break

        if os.path.sep == '\\' and local_os.lower() != 'glo':
            path = path.replace('/', '\\')

        else:
            path = path.replace('\\', '/')

        return path
