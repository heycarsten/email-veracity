require File.dirname(__FILE__) + '/../test_helper'


class DomainTest < Test::Unit::TestCase

  def test_initializing_a_new_domain_with_whitespace
    domain = EmailVeracity::Domain.new('  heycarsten.com  ')
    assert_equal 'heycarsten.com', domain.name, 'Should strip whitespace.'
    assert_respond_to domain, :to_s, 'Should have a to_s method.'
  end

  def test_a_valid_domain_for_servers
    domain = EmailVeracity::Domain.new('gmail.com')
    assert_operator 0, :<, domain.exchange_servers.size,
      'Should contain mail servers.'
    assert_operator 0, :<, domain.address_servers.size,
      'Should contain address servers.'
  end

  def test_an_invalid_domain_for_servers
    domain = EmailVeracity::Domain.new('i-surely-do-not.exist')
    assert_empty domain
  end

  def test_validatability
    
  end

end