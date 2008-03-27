require File.dirname(__FILE__) + '/../test_helper'


class ServerTest < Test::Unit::TestCase
  
  def test_creating_a_new_blank_server_object
    new_server = EmailVeracity::Server.new
    assert_equal '', new_server.to_s, 'Should yield a blank string on call to to_s.'
    assert_equal '', new_server.name, 'Should yield a blank string on call to name.'
    assert_nil new_server.type, 'Should return nil on a call to type.'
  end
  
  def test_creating_a_new_server_object_with_a_name_and_type
    name = 'cooltown.ca'
    type = :address
    new_server = EmailVeracity::Server.new(name, type)
    assert_equal name, new_server.name, 'Should yield the provided name on call to name.'
    assert_equal name, new_server.to_s, 'Should yield the provided name on call to to_s.'
    assert_equal type, new_server.type, 'Should yield the provided type on call to type.'
  end
  
  def test_creating_a_new_blank_server_object_and_setting_its_name_after_initialization
    name = 'igvita.com'
    type = :exchange
    new_server = EmailVeracity::Server.new
    new_server.name = name
    new_server.type = type
    assert_equal name, new_server.name, 'Should yield the provided name on call to name.'
    assert_equal name, new_server.to_s, 'Should yield the provided name on call to to_s.'
    assert_equal type, new_server.type, 'Should yield the provided type on call to type.'
  end
  
end