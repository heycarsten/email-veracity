module EmailVeracity
  
  
  # Defines a server contains methods used to retrieve information from it.
  class Server
    
    attr_accessor :name
    attr_accessor :type
    
    def initialize(name = '', type = nil)
      @name = name
      @type = type
    end
    
    def to_s #:nodoc:
      name
    end
    
  end
  
  
end