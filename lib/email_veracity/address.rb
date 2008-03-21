module EmailVeracity
  
  
  class Address
    
    attr_accessor :email_address
    
    def initialize(email = '')
      self.address = email
    end
    
    # Checks the email's domain against any invalid domains passed in the options
    # hash.  This is useful when you don't want addresses from providers such as
    # dodgeit.com.
    # ==== Options
    # * *invalid_domains*
    #   - An array of strings that indicate invalid domain names.
    # ==== Example
    # <tt>EmailAddress.new('carsten@dodgeit.com').domain_is_valid?(:invalid_domains => ['dodgeit.com']) # => false</tt>
    def domain_is_valid?(options = {})
      configuration = { :invalid_domains => nil }.update(options)
      return true unless configuration[:invalid_domains]
      unless configuration[:invalid_domains].is_a?(Array)
        raise ArgumentError, 'invalid_domains must be an Array'
      end
      !configuration[:invalid_domains].include?(domain.name.downcase)
    end
    
    # Returns the domain portion of the email address.
    # ==== Example
    # <tt>EmailAddress.new('heycarsten@gmail.com').domain # => "gmail.com"</tt>
    def domain
      Domain.new((address.split('@')[1] || '').strip)
    end
    
    # Verifies the email address for well-formedness against a well-known pattern.
    # Note that it will not verifiy all RFC 2822 valid addresses.
    def pattern_is_valid?
      address =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    end
    
    # Checks if the email address' domain has any servers in it's mail exchange (MX)
    # or address (A) records.  If it does then true is returned, otherwise false is
    # returned.  If the lookup times out, it will return false (or nil if the
    # :fail_on_timeout option is specified.)  Additionally the secondary (A record)
    # lookup can be turned off (if your really picky) by passing in the option
    # :mx_only => true.
    # ==== Options
    # * *mx_only*
    #   - The domain is only checked for the presence of mail exchange servers, the
    #     address record is ignored.
    # * *timeout*
    #   - Time (in seconds) before the domain lookup is skipped. Default is two.
    # * *fail_on_timeout*
    #   - Causes validation to fail if a timeout occurs.
    def domain_has_servers?(options = {})
      return true if EmailAddress.known_domains.include?(domain.name.downcase)
      servers = []
      servers << domain.exchange_servers(options)
      servers << domain.address_servers(options) if !options[:mx_only]
      servers.flatten!
      if (servers.size - servers.nitems) > 0
        options.fetch(:fail_on_timeout, true) ? nil : true
      else
        !servers.empty?
      end
    end
    
  end
  
  
end