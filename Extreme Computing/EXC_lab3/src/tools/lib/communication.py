# communication.py
import logging
import socket
import select
import cPickle as pickle
import settings
import sys
from general import get_replica_list
from enum import Enum

class MessageType(Enum):
  NONE            = 0
  READ            = 1
  UPDATE          = 2 
  UPDATE_ACK      = 3 
  UPDATE_PEER     = 4
  READ_REPLY      = 5 
  ERROR           = 6 
  def __int__(self):
    return self.value


class Message(object):
  def __init__(self, connection, message_type, message_body):
    self.connection = connection
    self.message_type = message_type
    self.message_body = message_body
    address, port = connection.getpeername()
    self.address = address
    arp_req = socket.gethostbyaddr(address)
    self.hostname = arp_req[0]
    self.port = port
  def __repr__(self):
    return "Message: Type: "  + str(self.message_type.name) + \
           ", Addr: " + str(self.address)           +  \
           ", Hostname: " + str(self.hostname)           +  \
           ", MessageBody: " + str(self.message_body)   


def read_message_fields(connection):
  # assume that there is no message by default
  message_type = MessageType.NONE
  pipe = connection.makefile("rb") 
  #read the length of the message first
  length_list = []
  while True:
    char = pipe.read(1)
    if char == '\n':
      break
    if char == '':
      # nothing to read
      pipe.close()
      return (message_type, '')        
    else:
      length_list.append(int(char))
  #read message type
  str_type = ''
  while True:
    char = pipe.read(1)
    if char == '\n':
      break
    else:
      str_type += char
  length = 0
  for digit in length_list:
    length = length * 10 + digit
  #read and unpack the the message 
  message_body = pipe.read(length)
  message_body_unpacked = pickle.loads(message_body) 
  pipe.close()
  message_type = MessageType(int(str_type))
  return (message_type, message_body_unpacked)


def read_message(connection):
  while True:
    r, w, e = select.select((connection,), (), (), 0)
    if r:
      message_type, message_body = read_message_fields(connection)
      if message_type is not MessageType.NONE:
        message = Message(connection, message_type, message_body)
        break
  return message


def open_send_connection(address, port):
  server_address = (address, port)
  # try to connect to the server
  connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  connection.connect(server_address)
  return connection


def open_receive_connection(port):
  connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  connection.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  try:
    connection.bind(('', port))
  except socket.error, e:
    print ('ERROR: ' + str(e) + '. Seems like a database is already running on this node. Run stop_distributed_db to stop a database on all nodes.')
    sys.exit(2)
  port_assigned = connection.getsockname()[1]
  connection.listen(1)
  print('Starting up a server. Listening on port ' + str(port_assigned))
  if len(get_replica_list()) > 1:
    print('Replication peers: ' + ", ".join(get_replica_list()[1:]))
  settings.Globals.socket = connection


def send_message(message, needs_ack=False):
  connection = message.connection
  #send the message
  pipe = connection.makefile("wb")
  message_body_packed = pickle.dumps( message.message_body, pickle.HIGHEST_PROTOCOL )
  # send the length of the message first
  pipe.write('%d\n' % len(message_body_packed))
  # then send the message type as int 
  pipe.write('%d\n' % int(message.message_type))
  # then send the packed message
  pipe.write(message_body_packed)
  pipe.flush()
  pipe.close()
  # if an acknoweledgement/response needed, keep the connection open until a reply is received
  if needs_ack:
    # read respnse
    response = read_message(connection)
    connection.close()
    return response
  connection.close()


from communication import read_message
from general import flush_logs_to_file
def process_message(message_handler, *args, **kwargs):
  # process incoming messages
  print('Waiting for a message to arrive...')
  # flush new message to log file in order the changes to be shown on AFS
  flush_logs_to_file()
  connection, source = settings.Globals.socket.accept()
  source_address, source_port = source
  print('Peer/source with IP address ' + str(source_address) + ':' + str(source_port) + ' connected.')
  message = read_message(connection)
  message_handler(message, *args, **kwargs)
  # connection was closed on the other end. Wait for another connection.
  connection.close()
  print('Connection to peer/source ' + str(source_address) + ':' + str(source_port) + ' was closed.\n')
