module EmailVeracity
  module Config

    DEFAULT_OPTIONS = {
      :whitelist => %w[
        aol.com
        gmail.com
        hotmail.com
        me.com
        mac.com
        msn.com
        rogers.com
        sympatico.ca
        yahoo.com
        telus.com
        sprint.com
        sprint.ca ],
      :blacklist => %w[
        dodgeit.com
        mintemail.com
        mintemail.uni.cc
        1mintemail.mooo.com
        spammotel.com
        trashmail.net ],
      :valid_pattern => %r{
        ^
        (
          [\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+
          \.
        )
        *
        [\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+
        @
        (
          (
            (
              (
                (
                  [a-z0-9]{1}
                  [a-z0-9\-]{0,62}
                  [a-z0-9]{1}
                )
                |
                [a-z]
              )
              \.
            )+
            [a-z]{2,6}
          )
          |
          (
            \d{1,3}
            \.
          ){3}
          \d{1,3}
          (
            \:\d{1,5}
          )?
        )
        $
      }xi,
      :must_include => [],
      :timeout => 2,
      :skip_lookup => false,
      :enforce_blacklist => false,
      :enforce_whitelist => true }
    @options = DEFAULT_OPTIONS.clone

    def [](key)
      @options[key.to_sym]
    end

    def []=(key, value)
      @options[key.to_sym] = value
    end

    def options
      @options
    end

    def options=(options)
      unless options.is_a?(Hash)
        raise ArgumentError, "options must be a Hash not #{options.class}"
      end
      @options = options
    end

    def update(options)
      unless options.is_a?(Hash)
        raise ArgumentError, "options must be a Hash not #{options.class}"
      end
      @options.update(options)
    end

    def enforced_record?(record)
      return unless @options[:must_include].is_a?(Array)
      @options[:must_include].any? { |i| i.to_s == record.to_s }
    end

    def revert!
      @options = DEFAULT_OPTIONS.clone
    end

    module_function :[], :[]=, :options, :options=, :update, :enforced_record?,
      :revert!

  end
end
