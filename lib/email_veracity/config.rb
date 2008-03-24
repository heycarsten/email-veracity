module EmailVeracity
  
  
  class Config
    
    # Set the defaults...
    @options = {
      :whitelist_domains => %w[ aol.com gmail.com hotmail.com mac.com msn.com
        rogers.com sympatico.ca yahoo.com ],
      :blacklist_domains => %w[ dodgeit.com mintemail.com mintemail.uni.cc
        1mintemail.mooo.com spammotel.com trashmail.net ],
      :valid_address_pattern => /\A(([\d\w\+_\-\.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})){1}\Z/i
    }
    
    def self.options
      @options
    end
  
  end
  
  
end