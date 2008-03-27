dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

require 'resolv'
require 'timeout'
require 'email_veracity/core_extensions'
require 'email_veracity/helper_mixins'
require 'email_veracity/errors'
require 'email_veracity/config'
require 'email_veracity/domain_resolver'
require 'email_veracity/server'
require 'email_veracity/domain'
require 'email_veracity/address'

module EmailVeracity
  
  VERSION = File.read('../VERSION').strip unless defined?(VERSION)
  
end