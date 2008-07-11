require File.dirname(__FILE__) + '/../test_helper'


class ResolverTest < Test::Unit::TestCase

  def test_consecutive_queries
    domain_names.each do |domain_name|
      EmailVeracity::Resolver.stubs(:get_resources_for).with(domain_name, kind_of(Symbol)).returns(["mail.#{domain_name}"])
    end
    
    assert_nothing_raised do
      domain_names.each do |domain|
        assert_instance_of Array, EmailVeracity::Resolver.get_servers_for(domain), 'Should return an array of servers'
      end
    end
  end

  def test_timing_out_while_resolving_a_domain
    domain = 'learnhub.com'
    timeout_exception = Timeout::Error.new('The connection has timed out')
    EmailVeracity::Resolver.stubs(:get_resources_for).with(domain, kind_of(Symbol)).raises(timeout_exception)
    
    assert_raise EmailVeracity::DomainResourcesTimeoutError, 'Should time out' do
      EmailVeracity::Resolver.get_servers_for(domain)
    end
  end

end