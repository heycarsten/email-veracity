require 'rubygems'
require 'rake'


task :default => :test

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end


### Packaging
require 'rake/gempackagetask'
load 'email_veracity.gemspec'
Rake::GemPackageTask.new(EV_GEMSPEC) do |pkg|
  if Rake.application.top_level_tasks.include?('release')
    pkg.need_tar_gz = true
    pkg.need_tar_bz2 = true
    pkg.need_zip = true
  end
end


task :install => [:package] do
  sudo = RUBY_PLATFORM =~ /win32/ ? '' : 'sudo'
  `#{sudo} gem install --no-ri pkg/email-veracity-#{EV_VERSION}`
end


### Coverage
require 'rcov/rcovtask'

Rcov::RcovTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.rcov_opts << '-x' << '"^\/"'
  if ENV['NON_NATIVE']
    t.rcov_opts << "--no-rcovrt"
  end
  t.verbose = true
end
