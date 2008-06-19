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


module EmailVeracity

  def self.version # :nodoc:
    return @@version if defined?(@@version)

    numbers = File.read(scope('VERSION')).strip.split('.').map { |n| n.to_i }

    @@version = {
      :major => numbers[0],
      :minor => numbers[1],
      :teeny => numbers[2] }

    @@version[:string] = [:major, :minor, :teeny].map { |comp| @@version[comp] }.compact.join('.')

    if File.exists?(scope('REVISION'))
      rev = File.read(scope('REVISION')).strip
      rev = nil if rev !~ /[a-f0-9]+/
    end

    if rev.nil? && File.exists?(scope('.git/HEAD'))
      rev = File.read(scope('.git/HEAD')).strip
      if rev =~ /^ref: (.*)$/
        rev = File.read(scope(".git/#{$1}")).strip
      end
    end

    if rev
      @@version[:rev] = rev
      @@version[:string] << "." << rev[0...7]
    end

    @@version
  end

  def self.scope(file) # :nodoc:
    File.join(File.dirname(__FILE__), '..', file)
  end

  VERSION = version[:string] unless defined?(EmailVeracity::VERSION)

end