require File.dirname(__FILE__) + '/../test_helper'


class ArrayExtensionsTest < Test::Unit::TestCase
  
  def test_reject_blank_items
    array = [[], {}, '', nil, '    ', 'good times!']
    assert_equal ['good times!'], array.reject_blank_items, 'Should reject all blank and empty objects.'
    array = [{:neat => 'o'}, ['cool'], 1, 's']
    assert_equal array, array.reject_blank_items, 'Should not reject any filled or not-blank objects.'
  end
  
  def test_contains_one_item?
    assert [''].contains_one_item?, 'Should contain one item.'
    assert [nil].contains_one_item?, 'Should contain one item.'
    assert [[]].contains_one_item?, 'Should contain one item.'
    assert ![].contains_one_item?, 'Should not contain one item.'
    assert ![nil, false].contains_one_item?, 'Should not contain one item.'
  end
  
end


class ValidityMixinTest < Test::Unit::TestCase
  
  def test_includes_proper_methods
    %w[ valid? validate! clear_errors! add_error errors ].each do |method_name|
      assert ClassWithValidationMock.new.methods.include?(method_name), "Should include '#{method_name}' method."
    end
  end
  
  def test_add_error
    mock = ClassWithValidationMock.new
    mock.give_error = true
    assert_equal 1, mock.errors.size, 'Should set one error.'
    mock.give_errors = true
    assert_equal [:error_one, :error_two, :error_three], mock.errors, 'Should have three errors.'
    assert_equal 3, mock.errors.size, 'Should reset errors then set one error and two more.'
  end
  
  def test_valid?
    mock = ClassWithValidationMock.new
    assert mock.valid?, 'Should be valid by default.'
    mock.give_error = true
    assert !mock.valid?, 'Should not be valid if errors are set.'
  end
  
  def test_errors
    assert ClassWithValidationMock.new.errors.empty?, 'Should be empty by default.'
  end
  
end 