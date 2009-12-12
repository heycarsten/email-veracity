require 'helper'

class TestServer < Test::Unit::TestCase

  def test_creating_a_new_blank_server_object
    new_server = EmailVeracity::Server.new
    assert_equal '', new_server.to_s,
      'Should yield a blank string on call to to_s.'
    assert_equal '', new_server.name,
      'Should yield a blank string on call to name.'
  end

  def test_creating_a_new_server_object_with_a_name_and_type
    name = 'cooltown.ca'
    new_server = EmailVeracity::Server.new(name)
    assert_equal name, new_server.name,
      'Should yield the provided name on call to name.'
    assert_equal name, new_server.to_s,
      'Should yield the provided name on call to to_s.'
  end

  def test_creating_a_new_blank_server_object_and_setting_its_name_after_initialization
    new_server = EmailVeracity::Server.new('igvita.com')
    assert_raise NoMethodError, 'Should fail miserably.' do
      new_server.name = name
    end
  end

end
