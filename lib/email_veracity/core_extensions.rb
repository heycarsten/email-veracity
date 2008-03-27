module EmailVeracity
  
  
  class ::Array
    
    def reject_blank_items
      reject { |i| i.to_s.strip.eql?('') }
    end
    
    def contains_one_item?
      size == 1
    end
    
  end
  
  
end