require File.dirname(__FILE__) + '/../test_helper'


class DomainTest < Test::Unit::TestCase

  def test_blacklisted_domain
    assert EmailVeracity::Domain.blacklisted?('dodgeit.com'),
      'Should match a blacklisted domain.'
    assert EmailVeracity::Domain.blacklisted?('DoDgEiT.cOm'),
      'Should match a blacklisted domain regardless of case.'
    assert EmailVeracity::Domain.blacklisted?(" dodgeit.com  \r\n "),
      'Should match a blacklisted domain regardless of whitespace.'
    assert !EmailVeracity::Domain.blacklisted?('iamnotblacklisted.com'),
      'Should not match a non-blacklisted domain.'
  end

  def test_whitelisted_domain
    assert EmailVeracity::Domain.whitelisted?('gmail.com'),
      'Should match a whitelisted domain.'
    assert EmailVeracity::Domain.whitelisted?('GmAiL.cOm'),
      'Should match a whitelisted domain regardless of case.'
    assert EmailVeracity::Domain.whitelisted?(" gmail.com  \r\n "),
      'Should match a whitelisted domain regardless of whitespace.'
    assert !EmailVeracity::Domain.whitelisted?('iamnotwhitelisted.com'),
      'Should not match a non-whitelisted domain.'
  end

  def test_initializing_a_new_domain_with_whitespace
    domain = new_domain('  heycarsten.com  ')
    assert_equal 'heycarsten.com', domain.name, 'Should strip whitespace.'
    assert_respond_to domain, :to_s, 'Should have a to_s method.'
  end

  def test_a_valid_domain_for_servers
    domain = new_domain('gmail.com')
    assert_not_empty domain.exchange_servers, 'Should contain mail servers.'
    assert_not_empty domain.address_servers, 'Should contain address servers.'
  end

  def test_a_valid_domain_with_whitespace_for_servers
    domain = new_domain('  learnhub.com  ')
    assert_not_empty domain.exchange_servers, 'Should contain mail servers.'
    assert_not_empty domain.address_servers, 'Should contain address servers.'
  end

  def test_an_invalid_domain_for_servers
    domain = new_domain('i-surely-do-not.exist')
    assert_empty domain.exchange_servers, 'Should not contain exchange servers.'
    assert_empty domain.address_servers, 'Should not contain address servers.'
  end

  def test_a_blank_domain_for_servers
    domain = new_domain('')
    assert_empty domain.exchange_servers, 'Should not contain exchange servers.'
    assert_empty domain.address_servers, 'Should not contain address servers.'
  end

  def test_for_errors_on_a_valid_domain
    domain = new_domain('yahoo.com')
    assert_empty domain.errors, 'Should not have errors.'
  end

  def test_for_errors_on_an_invalid_domain
    domain = new_domain('i-surely-do-not.exist')
    assert_not_empty domain.errors, 'Should have errors.'
  end

  private
    def new_domain(name = 'heycarsten.com')
      EmailVeracity::Domain.new(name)
    end

end