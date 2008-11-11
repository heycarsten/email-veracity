module EmailVeracity

  class Server

    attr_reader :name
    alias_method :to_s, :name

    def initialize(name = '')
      @name = name
    end

  end


  class AddressServer < Server; end
  class ExchangeServer < Server; end

end
