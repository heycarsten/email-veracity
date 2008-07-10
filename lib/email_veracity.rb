dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

require 'resolv'
require 'timeout'
require 'email_veracity/core_extensions'
require 'email_veracity/validatability'
require 'email_veracity/errors'
require 'email_veracity/config'
require 'email_veracity/server'
require 'email_veracity/resolver'
require 'email_veracity/domain'
require 'email_veracity/address'