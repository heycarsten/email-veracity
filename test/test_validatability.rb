require 'helper'

class TestValidatability < Test::Unit::TestCase

  def test_includes_proper_methods
    %w[ valid? validate! clear_errors! add_error errors ].each do |method_name|
      assert_respond_to ClassWithValidationMock.new, method_name
    end
  end

  def test_add_error
    mock = ClassWithValidationMock.new
    mock.give_error = true
    assert_equal 1, mock.errors.size, 'Should set one error.'
    mock.give_errors = true
    assert_equal [:one, :two, :three], mock.errors,
      'Should push tow new errors for a total of three.'
    mock.give_array_of_errors = true
    assert_equal [:one, :two, :three, :four, :five], mock.errors,
      'Should concat the array leaving two new errors for a total of five.'
  end

  def test_valid?
    mock = ClassWithValidationMock.new
    assert mock.valid?, 'Should be valid by default.'
    mock.give_error = true
    assert !mock.valid?, 'Should not be valid if errors are set.'
  end

  def test_errors
    assert ClassWithValidationMock.new.errors.empty?,
      'Should be empty by default.'
  end

end
