
import datajoint as dj

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
