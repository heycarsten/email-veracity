class ClassWithValidationMock

  include EmailVeracity::Validatability

  attr_accessor :give_error
  attr_accessor :give_errors

  def validate!
    add_error(:error_one) if give_error
    add_errors(:error_two, :error_three) if give_errors
    add_errors []
  end

end