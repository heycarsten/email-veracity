dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

require 'email_veracity/extensions'
require 'email_veracity/errors'
require 'email_veracity/config'
require 'email_veracity/address'
require 'email_veracity/domain'
require 'email_veracity/server'
require 'resolv'
require 'timeout'


module EmailVeracity
  
  VERSION = File.read('../VERSION').strip unless defined?(VERSION)
  
end