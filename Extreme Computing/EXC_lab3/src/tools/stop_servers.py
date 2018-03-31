#!/usr/bin/python

import os
from lib import general
from lib import settings
from optparse import OptionParser

def main():          
  # parse input options
  parser = OptionParser(usage='usage: %prog [-a <HOSTNAME>]')
  parser.add_option("-a", "--address", dest="address", help="node to stop a database instance on", metavar="HOSTNAME")
  (options, args) = parser.parse_args()

  # initialise settings object
  settings.init_settings()

  # read settings from settings.cfg
  general.set_configuration(enableLogging=False) 

  if options.address is None:
    for hostname in settings.Globals.hostname_list:
      general.stop_instance_on_node(hostname)
  else:
    general.stop_instance_on_node(options.address)
    full_hostname = general.get_full_hostname(options.address) 

if __name__ == "__main__":
  main()
