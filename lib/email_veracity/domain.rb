module EmailVeracity
  class Domain

    include Validatability

    def self.whitelisted?(name)
      Config[:whitelist].include?(name.downcase.strip)
    end

    def self.blacklisted?(name)
      Config[:blacklist].include?(name.downcase.strip)
    end

    def initialize(name = '')
      @name = name
    end

    def to_s
      name
    end

    def name
      @name.to_s.downcase.strip
    end

    def whitelisted?
      Domain.whitelisted?(name)
    end

    def blacklisted?
      Domain.blacklisted?(name)
    end

    def address_servers
      @address_servers ||= servers_in(:a)
    end

    def exchange_servers
      @exchange_servers ||= servers_in(:mx)
    end

    def servers
      address_servers + exchange_servers
    end

    protected

    def validate!
      return if whitelisted?
      add_error(:blacklisted) if blacklisted? &&
        Config[:enforce_blacklist]
      unless Config[:skip_lookup]
        add_error(:no_records) if servers.empty? &&
          !Config.enforced_record?(:a) &&
          !Config.enforced_record?(:mx)
        add_error(:no_address_servers) if address_servers.empty? &&
          Config.enforced_record?(:a)
        add_error(:no_exchange_servers) if exchange_servers.empty? &&
          Config.enforced_record?(:mx)
      end
    end

    def servers_in(record)
      return [] if Config[:skip_lookup] || Utils.blank?(name)
      Resolver.get_servers_for(name, record)
     rescue DomainResourcesTimeoutError
      add_error :timed_out
    end

  end
end
