module EmailVeracity
  
  
  # Defines a server contains methods used to retrieve information from it.
  class Server
    
    attr_accessor :name
    
    def to_s #:nodoc:
      name
    end
    
    def initialize(name = '')
      self.name = name
    end
    
  end
  
  
end