#!/usr/bin/python

from lib import general,settings 
from optparse import OptionParser
from lib.communication import MessageType,Message,open_send_connection,send_message

def main():
  # parse input options
  parser = OptionParser(usage='usage: %prog [-a <HOSTNAME>, -l]  -t <READ|UPDATE> -m <MESSAGE>')
  parser.add_option("-a", "--address", dest="address", help="host to send a message to", metavar="HOSTNAME")
  parser.add_option("-l", "--with-load-balancer", dest="use_load_balancer", help="enables load balancer, address option will be ignored", action="store_true", default=False)
  parser.add_option("-t", "--type", dest="message_type", help="host to send a message to", metavar="READ|UPDATE")
  parser.add_option("-m", "--message", dest="message_body", help="a message to be sent", metavar="STRING")
  (options, args) = parser.parse_args()
  if not options.address and not options.use_load_balancer:
    parser.error('ERROR: can fingure what node to send the message to. Please specify the node with -a <node>, or enable a load-balancer with -l.')
  if not options.message_body:
    parser.error('ERROR: Message is not specified')
  message_type = MessageType[options.message_type]
  if message_type is not MessageType.UPDATE and message_type is not MessageType.READ:
    parser.error('ERROR: Message type is not specified')

  # initialise settings object
  settings.init_settings()
  # read settings from settings.cfg
  general.set_configuration(enableLogging=False) 

  if options.use_load_balancer:
    # parse the message body to get the key
    key = general.parse_key(options.message_body)
    # use the hash function to find a rigth shard to send the message to
    target_address = settings.Globals.load_balancer.key_to_node(key)
  else:
    # use the address specified in the input optons
    target_address = options.address

  # try to find a node which responses
  for node in general.get_peer_list(target_address):
    try:
      # open connection
      connection = open_send_connection(node, settings.Globals.port)
      break
    except:
      print('WARNING: Failed to conned to ' + node + '. Trying another node.')
      continue
  # create a messge
  message = Message(connection, message_type, options.message_body)
  # send the message, wait for the acknoweledgement
  print('Sending ' + str(message))
  ack_message = send_message(message, needs_ack=True)
  print('Response ' + str(ack_message))

if __name__ == "__main__":
  main()
