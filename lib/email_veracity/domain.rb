module EmailVeracity
  
  
  class Domain
    
    include Validity
    
    DNS_RECORD_MAP = {
      :address => Resolv::DNS::Resource::IN::A,
      :exchange => Resolv::DNS::Resource::IN::MX }
    
    @@resolver = Resolv::DNS.new
    
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
      @address_servers ||= retrieve_servers_in(:address)
    end
    
    def exchange_servers
      @exchange_servers ||= retrieve_servers_in(:exchange)
    end
    
    def validate!
      return if Config.options[:offline]
      return if Config.whitelisted_domain?(name)
      add_error :blacklisted_domain if Config.blacklisted_domain?(name) &&
        !Config.options[:skip_blacklist_domains]
      add_error :no_address_servers if address_servers.empty? &&
        !Config.options[:skip_a_record_check]
      add_error :no_exchange_servers if exchange_servers.empty? &&
        !Config.options[:skip_mx_record_check]
    end
    
    protected
      def retrieve_servers_in(record)
        status = Timeout::timeout(Config.options[:timeout]) do
          records = @@resolver.getresources(name, DNS_RECORD_MAP[record])
          records.inject([]) do |array, resource|
            array << resource.method(record).call.to_s.strip
          end.reject_blank_items
        end
       rescue Timeout::Error
        add_error :timed_out
      end
      
  end
  
  
end