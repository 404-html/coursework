# routing.py

import general

class Loadbalancer():
  def __init__(self, node_names, hashing_method):
    self.node_names = node_names
    self.num_of_peers = len(self.node_names)
    self.hashing_method = hashing_method
  def key_to_node(self, key):
    return self.node_names[general.hash_key(key, self.hashing_method, self.num_of_peers)]
