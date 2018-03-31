#!/usr/bin/python

from lib import settings
from lib import general,communication
from lib import message_handlers


def main():          
  # wait for incomming messages 
  # once received a message, process the message with the specified handler 
  # keep waiting for new messages
  try:
    message_handler = getattr(message_handlers, settings.Globals.message_handler)
  except:
    print('ERROR: No such message handler ' + settings.Globals.message_handler)
  while True:
    # process messages
    communication.process_message(message_handler)

if __name__ == "__main__":
  # read settings.cfg
  general.configure()
  # do work
  main()
