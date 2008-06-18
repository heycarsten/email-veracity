module EmailVeracity


  class ::Array

    def reject_blank_items
      reject { |i| i.to_s.strip.blank? }
    end

    def contains_single_item?
      size == 1
    end

  end


  class ::Object

    # Snaked from Rails.
    def blank?
      respond_to?(:empty?) ? empty? : !self
    end

  end


end