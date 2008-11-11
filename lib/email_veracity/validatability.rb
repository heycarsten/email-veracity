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
      @errors.concat(new_errors.flatten)
    end
    alias_method :add_errors, :add_error

  end
end
