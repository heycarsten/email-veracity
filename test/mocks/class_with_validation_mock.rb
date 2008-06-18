class ClassWithValidationMock

  include EmailVeracity::Validatability

  attr_accessor :give_error
  attr_accessor :give_errors
  attr_accessor :give_array_of_errors

  def validate!
    add_error(:one) if give_error
    add_errors(:two, :three) if give_errors
    add_errors([:four, :five]) if give_array_of_errors
    add_errors []
  end

end