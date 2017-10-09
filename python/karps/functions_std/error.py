

class CreationError(Exception):
    def __init__(self, message):
        # Call the base class constructor with the parameters it needs
        super(Exception, self).__init__(message)

def create_error(msg):
  # TODO: add some information about the node stack.
  raise CreationError(msg)
