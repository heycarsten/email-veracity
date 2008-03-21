module EmailVeracity
  
  
  class Configuration
    
    # Set the defaults...
    @@whitelist_domains = %w[ aol.com gmail.com hotmail.com mac.com msn.com
      rogers.com sympatico.ca yahoo.com ]
    @@blacklist_domains = %w[ dodgeit.com mintemail.com mintemail.uni.cc
      1mintemail.mooo.com spammotel.com trashmail.net ]
    @@valid_address_pattern = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    
    def self.whitelist_domains
      @@whitelist_domains
    end
    
    def self.whitelist_domains=(domains)
      raise ArgumentError, 'domains must be an array.' unless domains.is_a?(Array)
      @@whitelist_domains = domains
    end
    
    def self.blacklist_domains
      @@blacklist_domains
    end
    
    def self.blacklist_domains=(domains)
      raise ArgumentError, 'domains must be an array.' unless domains.is_a?(Array)
      @@blacklist_domains = domains
    end
    
    def self.valid_address_pattern
      @@valid_address_pattern
    end
    
    def self.valid_address_pattern=(pattern)
      raise ArgumentError, 'pattern must be a regexp.' unless pattern.is_a?(Regexp)
      @@valid_address_pattern = pattern
    end
    
  end
  
  
end