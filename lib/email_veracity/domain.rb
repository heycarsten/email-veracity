module EmailVeracity
  
  
  # Defines a domain and contains methods used to retrieve information from it such
  # as mail exchange and address server information.
  class Domain
    
    attr_accessor :name
    
    def initialize(name = '')
      self.name = name
    end
    
    def to_s #:nodoc:
      name
    end
    
    def address_servers(options = {})
      servers_in :address, options
    end
    
    def exchange_servers(options = {})
      servers_in :exchange, options
    end
    
    protected
      def servers_in(record, options = {})
        type = case record.to_s.downcase
          when 'exchange' : Resolv::DNS::Resource::IN::MX
          when 'address' : Resolv::DNS::Resource::IN::A
        end
        st = Timeout::timeout(options.fetch(:timeout, 2)) do
          Resolv::DNS.new.getresources(name, type).inject([]) do |servers, s|
            servers << Server.new(s.send(record).to_s)
          end
        end
       rescue Timeout::Error
        nil
      end
      
  end
  
  
end