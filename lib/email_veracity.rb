dir = File.dirname(__FILE__)
$LOAD_PATH << dir unless $LOAD_PATH.include?(dir)

require 'email_veracity/extensions'
require 'email_veracity/configuration'
require 'email_veracity/address'
require 'email_veracity/domain'
require 'email_veracity/server'