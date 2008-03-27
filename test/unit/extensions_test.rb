require File.dirname(__FILE__) + '/../test_helper'


class ArrayExtensionsTest < Test::Unit::TestCase
  
  def test_reject_blank_items
    array = [[], {}, '', nil, '    ', 'good times!']
    assert_equal 1, array.reject_blank_items.size, 'Should reject all blank and empty objects.'
    array = [{:neat => 'o'}, ['cool'], 1, 's']
    assert_equal 4, array.reject_blank_items.size, 'Should not reject any filled or not-blank objects.'
  end
  
end


class ValidityMixinTest < Test::Unit::TestCase
  
  def test_includes_proper_methods
    flunk 'Should be tested!'
  end
  
end 