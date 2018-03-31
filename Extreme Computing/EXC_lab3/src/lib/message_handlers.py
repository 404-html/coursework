# message_handlers.py 

import settings as main
import socket
from general import get_replica_list
from communication import Message,MessageType,send_message,read_message,open_send_connection 

def empty_message_handler(message, *args, **kwargs):
  print('Received a ' + str(message)) # do nothing 

#------------------------------------------------------------------------

def simple_message_handler(message, *args, **kwargs):
  print('Received a ' + str(message)) 

  if message.message_type is MessageType.UPDATE:
    # parse the message body
    try:
      key, value = message.message_body.split(':')
    except ValueError:
      print_string = 'ERROR: can not parse key-value in the received message. The pair WAS NOT added to the table. The correct format is <key>:<value>.'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)
      return
    # add key value pair to the database
    main.Globals.database.add(key, value) 
    # send an acknoweledge
    ack_message = Message(message.connection, MessageType.UPDATE_ACK, 'Success')
    send_message(ack_message)

  if message.message_type is MessageType.READ:
    # message_body is a key for this type of request
    key = message.message_body
    # try to find key in the database
    try:
      value = main.Globals.database.get(key) 
    except KeyError:
      print_string = 'ERROR: can not find a key ' + key + ' in the table.'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)
      return
    reply_message = Message(message.connection, MessageType.READ_REPLY, value)
    send_message(reply_message)

#------------------------------------------------------------------------

def fault_tolerant_message_handler(message, *args, **kwargs):
  print('Received a ' + str(message)) 

  if message.message_type is MessageType.UPDATE:
    # parse the message body
    try:
      key, value = message.message_body.split(':')
    except ValueError:
      print_string = 'ERROR: can not parse key-value in the received message. The pair WAS NOT added to the table. The correct format is <key>:<value>.'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)
      return
    # add key value pair to the database
    main.Globals.database.add(key, value) 
    # send to peers
    peer_responses = []
    for peer_address in get_replica_list()[1:]:
      try:
        connection = open_send_connection(peer_address, main.Globals.port) 
        peer_update_message = Message(connection, MessageType.UPDATE_PEER, message.message_body)
        response_message = send_message(peer_update_message, needs_ack=True)
        peer_responses.append(response_message.message_type)
        connection.close()
      except socket.error, e:
        print ('WARNING: was not able to connect to peer ' + peer_address + '. Seems that database does not run on that node.' )
    # if at least one peer successfully allocated a key-value pair, send an acknoweledge
    if MessageType.UPDATE_ACK in peer_responses:
      ack_message = Message(message.connection, MessageType.UPDATE_ACK, 'Success')
      send_message(ack_message)
    else:
      print_string = 'ERROR: was not able to allocate a key:value pair in at least two nodes: replication failed'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)

  if message.message_type is MessageType.READ:
    # message_body is a key for this type of request
    key = message.message_body
    # try to find key in the database
    try:
      value = main.Globals.database.get(key) 
    except KeyError:
      print_string = 'ERROR: can not find a key ' + key + ' in the table.'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)
      return
    reply_message = Message(message.connection, MessageType.READ_REPLY, value)
    send_message(reply_message)

  if message.message_type is MessageType.UPDATE_PEER:
    # parse the message body
    try:
      key, value = message.message_body.split(':')
    except ValueError:
      print_string = 'ERROR: can not parse key-value in the received message. The pair WAS NOT added to the table. The correct format is <key>:<value>.'
      print(print_string)
      error_reply_message = Message(message.connection, MessageType.ERROR, print_string)
      send_message(error_reply_message)
      return
    # add key value pair to the database
    main.Globals.database.add(key, value) 
    # send an acknoweledge
    ack_message = Message(message.connection, MessageType.UPDATE_ACK, 'Success')
    send_message(ack_message)
