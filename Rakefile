# I used Haml as a template for these tasks: Thank you Nex3!
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


task :release => [:package] do
  name, version = ENV['NAME'], ENV['VERSION']
  raise "Must supply NAME and VERSION for release task." unless name && version
  `rubyforge login`
  `rubyforge add_release email-veracity email-veracity "#{name} (v#{version})" pkg/email-veracity-#{version}.gem`
  `rubyforge add_file    email-veracity email-veracity "#{name} (v#{version})" pkg/email-veracity-#{version}.tar.gz`
  `rubyforge add_file    email-veracity email-veracity "#{name} (v#{version})" pkg/email-veracity-#{version}.tar.bz2`
  `rubyforge add_file    email-veracity email-veracity "#{name} (v#{version})" pkg/email-veracity-#{version}.zip`
end



### Documentation
require 'rake/rdoctask'

Rake::RDocTask.new do |rdoc|
  rdoc.title    = 'Email Veracity'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include(*FileList.new('*') do |list|
                            list.exclude(/(^|[^.a-z])[a-z]+/)
                            list.exclude('TODO')
                          end.to_a)
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.exclude('TODO')
  rdoc.rdoc_dir = 'rdoc'
  rdoc.main = 'README.rdoc'
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