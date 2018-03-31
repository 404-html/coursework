# database.py

class Database(object):
  def __init__(self):
    self.table = {}

  def add(self, key, value):
    self.table[key] = value
    print('Add an entry to the database: key: ' + key + ', value: ' + value)
  
  def get(self, key):
    return self.table[key]
