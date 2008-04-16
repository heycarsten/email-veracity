module EmailVeracity


  class Config

    # Set the defaults...
    @options = {
      :whitelist_domains => %w[ aol.com gmail.com hotmail.com mac.com msn.com
        rogers.com sympatico.ca yahoo.com telus.com sprint.com sprint.ca ],
      :blacklist_domains => %w[ dodgeit.com mintemail.com mintemail.uni.cc
        1mintemail.mooo.com spammotel.com trashmail.net ],
      :valid_address_pattern => /\A(([\d\w\+_\-\.]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})){1}\Z/i,
      :timeout => 2,
      :skip_a_record_check => false,
      :skip_mx_record_check => true,
      :skip_blacklist_domains => true,
      :skip_whitelist_domains => false,
      :check_pattern_only => false }

    def self.options
      @options
    end

    def self.blacklisted_domain?(domain)
      @options[:blacklist_domains].include?(domain.downcase.strip)
    end

    def self.whitelisted_domain?(domain)
      @options[:whitelist_domains].include?(domain.downcase.strip)
    end

  end


end