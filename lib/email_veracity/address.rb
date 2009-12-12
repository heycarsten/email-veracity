module EmailVeracity
  class Address

    include Validatability

    attr_reader :domain

    def initialize(email = '')
      self.email_address = email
    end

    def to_s
      email_address
    end

    def email_address
      @email_address.to_s.strip
    end

    def email_address=(new_email_address)
      @email_address = new_email_address.to_s
      @domain = Domain.new(@email_address.split('@')[1] || '')
    end

    protected

    def validate!
      add_error(:malformed) if !pattern_valid?
      add_errors(domain.errors)
    end

    def pattern_valid?
      @email_address =~ Config[:valid_pattern]
    end

  end
end
