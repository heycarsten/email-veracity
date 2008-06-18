module EmailVeracity


  class Domain

    include Validatability

    def initialize(name = '')
      @name = name
    end

    def to_s
      name
    end

    def name
      @name.to_s.downcase.strip
    end

    def address_servers
      @address_servers ||= servers_in(:a)
    end

    def exchange_servers
      @exchange_servers ||= servers_in(:mx)
    end

    protected
      def validate!
        return if Config.options[:offline]
        return if Config.whitelisted_domain?(name)
        add_error(:blacklisted_domain) if Config.blacklisted_domain?(name) &&
          !Config.options[:skip_blacklist_domains]
        add_error(:no_address_servers) if address_servers.empty? &&
          !Config.options[:skip_a_record_check]
        add_error(:no_exchange_servers) if exchange_servers.empty? &&
          !Config.options[:skip_mx_record_check]
      end

      def servers_in(record)
        return [] if name.blank?
        Resolver.get_servers_for(name, :in => record)
       rescue DomainResourcesTimeoutError
        add_error :timed_out
      end

  end


end