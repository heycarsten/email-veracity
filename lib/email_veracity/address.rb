module EmailVeracity
  
  
  class Address
    
    attr_accessor :email_address
    attr_reader :domain
    
    def initialize(email = '')
      self.email_address = email
    end
    
    def to_s
      @email_address.to_s
    end
    
    def email_address=(new_email_address)
      @email_address = new_email_address
      @domain = Domain.new((@email_address.split('@')[1] || '').split)
    end
    
    def valid?
      pattern_valid? && domain.valid?
    end
    
    protected
      def pattern_valid?
        @email_address =~ Config.options[:valid_address_pattern]
      end
      
  end
  
  
end