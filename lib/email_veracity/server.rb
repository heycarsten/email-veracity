module EmailVeracity


  class Server

    attr_accessor :name
    attr_accessor :type

    def initialize(name = '', type = nil)
      @name = name
      @type = type
    end

    def to_s
      name
    end

  end


end