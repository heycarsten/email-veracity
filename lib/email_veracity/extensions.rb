module EmailVeracity
  
  
  class ::Array
    
    def reject_blank_items
      reject { |i| i.to_s.strip.eql?('') }
    end
    
  end
  
  
  module Validity
    
    def valid?
      self.errors.empty?
    end
    
    def validate!
      # This method adds errors to the object.
    end
    
    def clear_errors!
      @errors = []
    end
    
    def add_error(error)
      @errors ||= []
      if error.is_a?(Array)
        @errors | error
      else
        @errors << error
      end
    end
    alias_method :add_errors, :add_error
    
    def errors
      self.clear_errors!
      self.validate!
      (@errors || []).flatten
    end
    
  end
  
  
end