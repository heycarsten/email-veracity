module EmailVeracity
  
  
  # Defines a domain and contains methods used to retrieve information from it such
  # as mail exchange and address server information.
  class Domain
    
    require 'resolv'
    require 'timeout'
    
    attr_accessor :name
    
    # Creates a new Domain object, optionally accepts a domain as an argument.
    # ==== Example
    # <tt>Domain.new('gmail.com').exchange_servers # => ["ms1.google.com",
    # "ms2.google.com", ...]</tt>
    def initialize(name = '')
      self.name = name
    end
    
    def to_s #:nodoc:
      name
    end
    
    # Returns an array of server objects for address server the domain's A record, if
    # the domain does not exist, it will return an empty array.  If it times out, nil
    # is returned.
    # ==== Options
    # * *timeout*
    #   - Sets a time (in seconds) that the method will time out and return nil.  The
    #     default is two.
    def address_servers(options = {})
      servers_in :address, options
    end
    
    # Returns an array of server objects for each exchange server in the domain's MX
    # record, if the domain does not exist, it will return an empty array. If it times
    # out, nil is returned.
    # ==== Options
    # * *timeout*
    #   - Sets a time (in seconds) that the method will time out and return nil.  The
    #     default is two.
    def exchange_servers(options = {})
      servers_in :exchange, options
    end
    
    protected
      # Returns an array of server objects from the domain using the specified method.
      # If the domain does not exist an empty array is returned.  If the process times
      # out, nil is returned.
      # ==== Arguments
      # * *record*
      #   - Either <tt>:exchange</tt> to return mail exchange servers (MX) or
      #     <tt>:address</tt> to return primary address servers (A)
      # ==== Options
      # * *timeout*
      #   - Sets a time (in seconds) that the method will time out and return nil.  The
      #     default is two.
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