module EmailVeracity
  module Utils

    def blank?(obj)
      obj.respond_to?(:empty?) ? obj.empty? : !obj
    end

    module_function :blank?

  end
end
