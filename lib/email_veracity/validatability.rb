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
        # Adds errors to the object.
      end

      def clear_errors!
        @errors = []
      end

      def add_error(*new_errors)
        @errors ||= []
        if new_errors.has_one_item?
          error = new_errors.pop
          @errors << error unless error.is_a?(Array)
        else
          @errors.concat(new_errors)
        end
      end
      alias_method :add_errors, :add_error

  end


end