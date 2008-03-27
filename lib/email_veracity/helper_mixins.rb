module EmailVeracity
  
  
  module Validatability
    
    def valid?
      self.errors.empty?
    end
    
    def errors
      self.clear_errors!
      self.validate!
      @errors
    end
    
    protected
      def validate!
        # This method adds errors to the object.
      end
      
      def clear_errors!
        @errors = []
      end
      
      def add_error(*new_errors)
        @errors = [] unless defined?(@errors)
        if new_errors.contains_one_item?
          error = new_errors.pop
          @errors << error unless error.is_a?(Array)
        else
          @errors.concat(new_errors)
        end
      end
      alias_method :add_errors, :add_error
      
  end
  
  
end