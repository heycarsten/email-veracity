require File.dirname(__FILE__) + '/../test_helper'


class DomainResolverTest < Test::Unit::TestCase

  def test_consecutive_resolve_queries
    EmailVeracity::Config.options[:timeout] = 60
    assert_nothing_raised do
      domain_names.each do |domain|
        assert_instance_of Array,
          EmailVeracity::DomainResolver.get_servers_for(domain),
          'Should return an array of servers'
      end
    end
  end

  def test_timing_out_while_resolving_a_domain
    EmailVeracity::Config.options[:timeout] = 0.001
    assert_raise EmailVeracity::DomainResourcesTimeoutError, 'Should time out' do
      EmailVeracity::DomainResolver.get_servers_for('learnhub.com')
    end
    EmailVeracity::Config.options[:timeout] = 2
  end

end