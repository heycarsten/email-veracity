module EmailVeracity


  class Config

    DEFAULT_OPTIONS = @options = {
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

    def self.[](key)
      @options[key.to_sym]
    end

    def self.[]=(key, value)
      @options[key.to_sym] = value
    end

    def self.options
      @options
    end

    def self.options=(options)
      unless options.is_a?(Hash)
        raise ArgumentError, "options must be a Hash not #{options.class}"
      end
      @options = options
    end

    def self.revert_to_defaults!
      options = DEFAULT_OPTIONS
    end

  end


end