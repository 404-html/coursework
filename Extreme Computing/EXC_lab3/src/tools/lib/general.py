import cPickle as pickle 
import hashlib
import logging
import logging.handlers
import getpass
import socket
import select
import os
import settings
import ConfigParser
import sys
import signal
import routing

from database import Database

def hash_key(key, method, boundary):
  try:
    hash_function = getattr(hashlib, method)
  except AttributeError:
    return int(key) % boundary
  hashed_key_base10 = int(hash_function(str(key).encode()).hexdigest(), 16)
  return hashed_key_base10 % boundary

def user_to_port(key):
  hash_function = getattr(hashlib, 'md5')
  hashed_key_base10_shifted = 1024 + (int(hash_function(str(key).encode()).hexdigest(), 16) % (65535 - 1024))
  return hashed_key_base10_shifted 

def get_peer_list(hostname):
  full_hostname = get_full_hostname(hostname)
  whole_peer_list = settings.Globals.hostname_list
  peer_index = whole_peer_list.index(full_hostname)
  num_replicas = len(whole_peer_list)
  peer_start = peer_index 
  peer_end = (peer_start + num_replicas)
  res_list = whole_peer_list[peer_start:peer_end]
  if peer_end > len(whole_peer_list):
    res_list += whole_peer_list[0:peer_end % len(whole_peer_list)]
  return res_list

def get_replica_list():
  whole_peer_list = settings.Globals.hostname_list
  peer_index = int(settings.Globals.peer_num)
  num_replicas = int(settings.Globals.num_replicas)
  peer_start = peer_index 
  max_index = len(whole_peer_list) 
  peer_end = (peer_start + num_replicas)
  res_list = whole_peer_list[peer_start:peer_end]
  if peer_end > len(whole_peer_list):
    res_list += whole_peer_list[0:peer_end % len(whole_peer_list)]
  return res_list

def signal_handler(signal, frame):
  if settings.Globals.socket:
    # shutdown both ends
    settings.Globals.socket.shutdown(socket.SHUT_RDWR)
    settings.Globals.socket.close()
  print('Shutting down: You pressed Ctrl+C!')
  sys.exit(0)

def get_full_hostname(hostname):
  try:
    full_hostname = socket.gethostbyaddr(socket.gethostbyname(hostname))[0]
    return full_hostname
  except: 
    print('WARNING: can not launch database on node ' + hostname + ' : the node can not be found. Please check settings in settings.cfg.')

def setup_logging():
  # setup log file path and log severity	
  hostname = socket.gethostname()
  log_dir = os.path.join(settings.Globals.lab3_root_path, 'logs')
  log_file_name = os.path.join(log_dir, hostname + '.log')
  log_dir = os.path.dirname(log_file_name)
  if not os.path.isdir(log_dir):
    os.makedirs(log_dir)
  log_levels = {'CRITICAL' : logging.CRITICAL,
      'ERROR' : logging.ERROR,
      'WARNING' : logging.WARNING,
      'INFO' : logging.INFO,
      'DEBUG' : logging.DEBUG
  }
  if settings.Globals.verbose_logging:
    logging_level = 'INFO'	
  else:
    logging_level = 'ERROR'
  log_format='%(asctime)s:%(name)s:%(message)s'
  logging.basicConfig(
    format=log_format,
    filename=log_file_name,
    level=log_levels[logging_level],
    filemode='w'
  )
  logger = logging.getLogger('SHARD')
  log_handler = logging.handlers.WatchedFileHandler(log_file_name)
  log_handler.setFormatter(logging.Formatter(log_format))
  logger.addHandler(log_handler)

  return logger


def redirect_sys_outs_to_log_file():
  class StreamToLogger(object):
    def __init__(self, logger, log_level=logging.INFO):
      self.logger = logger
      self.log_level = log_level
      self.linebuf = ''

    def write(self, buf):
      for line in buf.rstrip().splitlines():
        self.logger.log(self.log_level, line.rstrip())

  stdout_logger = logging.getLogger('SHARD')
  sl = StreamToLogger(stdout_logger, logging.INFO)
  sys.stdout = sl

  stderr_logger = logging.getLogger('SHARD')
  sl = StreamToLogger(stderr_logger, logging.ERROR)
  sys.stderr = sl

def set_remote_configuration():
  settings.Globals.pids_file_name = os.path.join(settings.Globals.lab3_root_path, '.metadata', settings.Globals.hostname)
  if not os.path.isdir(os.path.dirname(settings.Globals.pids_file_name)):
    os.makedirs(os.path.dirname(settings.Globals.pids_file_name))
  if os.path.exists(settings.Globals.pids_file_name):
    settings.Globals.logger.critical( 'Error: It seems like server(s) are already running: the metadata file\n' + \
          settings.Globals.pids_file_name + \
          ' already exists.\n\nPlease shutdown the server(s) or remove the metadata file with the following command\n\trm ' \
          + settings.Globals.pids_file_name )
    sys.exit(-1)
  with open(settings.Globals.pids_file_name, 'w') as pid_file:
    pid_file.write(str(os.getpid()))

  
  
def set_lab3_root_path():
  try: 
    if os.environ['EXC_LAB3_ROOT_DIR'] == '': 
      print >>sys.stderr, "ERROR: Root dir is not specidied. Please use -r to specify root_dir."
      sys.exit(-1)
  except KeyError, e:
    print 'I got a KeyError. Reason: bash variable "%s" is not initialised.'  % str(e)    
    print 'It seems that your bash environment is not initialised for work with the lab3.\nPlease execute the following command in your terminal:\ncd <PATH_TO_EXC_LAB3_DIRECTORY> ; source shrc'    
    sys.exit(-1)
  settings.Globals.lab3_root_path = os.environ['EXC_LAB3_ROOT_DIR']  
  if not os.path.isdir(settings.Globals.lab3_root_path):
    print >>sys.stderr, 'ERROR: Root dir "%s" does not exist.' % root_dir
    sys.exit(-1)


def set_configuration(root_dir=None, enableLogging=True):
  # set lab3 root path
  if root_dir is None:
    set_lab3_root_path()
  else:
    settings.Globals.lab3_root_path = root_dir

  # set common settings
  settings.Globals.username = getpass.getuser()
  settings.Globals.port = user_to_port(settings.Globals.username)
  settings.Globals.hostname = get_full_hostname(socket.gethostname())
  config = ConfigParser.ConfigParser()
  config.read(os.path.join(settings.Globals.lab3_root_path, 'settings.cfg'))
  if enableLogging:
    settings.Globals.verbose_logging = config.getboolean('General_parameters', 'verbose_logging')
    settings.Globals.logger = setup_logging()
  settings.Globals.num_replicas = config.get('General_parameters', 'number_replicas')
  settings.Globals.message_handler = config.get('General_parameters', 'message_handler')
  settings.Globals.hostname_list = [ get_full_hostname(hostname) for alias,hostname in config.items('Node_hostnames') ] 
  try:
    settings.Globals.peer_num = settings.Globals.hostname_list.index(settings.Globals.hostname)
  except ValueError,e:
    print('ERROR: ' + str(e))
    pass
  loadbalancer_hashing_funciton = config.get('General_parameters', 'hashing_function')
  settings.Globals.load_balancer = routing.Loadbalancer(settings.Globals.hostname_list, loadbalancer_hashing_funciton)

  #initialise local database
  settings.Globals.database = Database()


def read_metadata():
  pid_list = {}
  metadata_dir = os.path.join(settings.Globals.lab3_root_path, '.metadata')
  if not os.path.isdir(metadata_dir):
    settings.Globals.logger.critical( "ERROR: It seems that servers are not running." )
    sys.exit(-1)
  for hostname in settings.Globals.hostname_list:
    try: 
      with open(os.path.join(metadata_dir, hostname), 'r') as f:
        pid_list[hostname] = f.read().strip()	
    except IOError:
      pass
  return pid_list

  
def remove_metadata(hostname):
  metadata_dir = os.path.join(settings.Globals.lab3_root_path, '.metadata')
  os.remove(os.path.join(metadata_dir, hostname))    

def flush_logs_to_file():
  handlers = settings.Globals.logger.handlers[:]
  for handler in handlers:
    handler.close()


import communication,settings 
from optparse import OptionParser
def parseOptions():
  parser = OptionParser(usage='usage: %prog [-r -s <LAB3_ROOT_DIR>]')
  parser.add_option("-r", "--remote",
                    action="store_true", dest="remote_mode", default=False,
                    help="enables remote mode. Should be used when launched on a remote machines")
  parser.add_option("-s", "--lab3_root_path", dest="root_dir",
                    help="path to root dir. Used only in remote mode", metavar="DIR")
  return parser.parse_args()

def configure():
  # register SININT singal handler
  signal.signal(signal.SIGINT, signal_handler)
  # parse input options
  (options, args) = parseOptions()
  # disable root_dir if not in remote mode
  if not options.remote_mode:
    options.root_dir = None
  # initialise settings object
  settings.init_settings()
  # read settings from settings.cfg
  set_configuration(options.root_dir) 
  if options.remote_mode:
    # register itself as running 
    set_remote_configuration()
    # redirect all output to a log file
    redirect_sys_outs_to_log_file()
  # open a connection  
  communication.open_receive_connection(settings.Globals.port)

def parse_key(message_body):
  try: 
    key, rest = message_body.split(':')
  except ValueError:
    key = message_body
  return key

def stop_instance_on_node(hostname):
  full_hostname = get_full_hostname(hostname)
  pid_list = read_metadata()
  execute_over_ssh = 'ssh -o "StrictHostKeyChecking no" ' + settings.Globals.username + '@' + full_hostname 
  try:
    command = execute_over_ssh + ' \' kill ' + pid_list[full_hostname] + ' &> /dev/null \' '
  except KeyError as e:
    print 'WARNING: Can not stop a server instance on the node',e,': PID was not found. Apparently, a server instance was not running on that node.'
    return
  os.system(command)
  remove_metadata(full_hostname)		
  print 'Stoped server on node ' + full_hostname + '.'
