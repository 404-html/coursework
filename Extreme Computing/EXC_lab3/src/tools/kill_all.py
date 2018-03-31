#!/usr/bin/python

import os
from lib import general
from lib import settings


def main():          
  # initialise settings object
  settings.init_settings()

  # read settings from settings.cfg
  general.set_configuration() 

  # Run server instance remotely on the hosts from hostname_list 
  for hostname in settings.Globals.hostname_list:
    execute_over_ssh = 'ssh -o "StrictHostKeyChecking no" ' + settings.Globals.username + '@' + hostname 
    command =  execute_over_ssh + ' \' ' + os.path.join(settings.Globals.lab3_root_path, 'src/tools/kill_all.sh' ) + ' \' '
    print 'Killed all server instances on node ' + hostname + '.'
    os.system(command)


if __name__ == "__main__":
  main()
