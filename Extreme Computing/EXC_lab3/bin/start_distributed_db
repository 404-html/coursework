#!/usr/bin/python
import os
from lib import general
from lib import settings


def main():          
  # initialise settings object
  settings.init_settings()

  # read settings from settings.cfg
  general.set_configuration(enableLogging=False) 

  # Run server instance remotely on the hosts from hostname_list 
  for hostname in settings.Globals.hostname_list:
    execute_over_ssh = 'ssh -f -o "StrictHostKeyChecking no" ' + settings.Globals.username + '@' + hostname 
    command =  execute_over_ssh + ' \' ' + os.path.join(settings.Globals.lab3_root_path, 'src/server.py -r -s ' + settings.Globals.lab3_root_path ) + ' \' >/dev/null 2>&1 '
    log_filename = os.path.join(settings.Globals.lab3_root_path, 'logs', hostname)
    print 'Started server on node ' + hostname + '. See a log ' + log_filename + '.log for details.'
#    print command
    os.system(command)

if __name__ == "__main__":
  main()
