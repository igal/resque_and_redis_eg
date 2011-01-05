require 'lib/greeter'
require 'lib/pingpong'

require 'rubygems'
require 'resque'
require 'resque/tasks'

#---[ Common ]----------------------------------------------------------

desc "Console"
task :console do
  require 'irb'
  ARGV.clear
  IRB.start
end

desc "Run a worker"
task :work do
  ENV['VERBOSE'] = '1' unless ENV['VERBOSE']
  ENV['QUEUE'] = '*' unless ENV['QUEUE']
  Rake::Task['resque:work'].invoke
end

desc 'Run workers as threads'
task :workers do
  ENV['VERBOSE'] = '1' unless ENV['VERBOSE']
  ENV['QUEUE'] = '*' unless ENV['QUEUE']
  ENV['COUNT'] = '10' unless ENV['COUNT']
  Rake::Task['resque:workers'].invoke
end

desc 'Display log messages'
task :log do
  exec 'tail -F --retry log/*.log'
end

desc 'Clear log messages'
task 'log:clear' do
  Dir['log/*.log'].each do |filename|
    rm filename
  end
end

#---[ Apps ]------------------------------------------------------------

namespace :greeter do
  desc 'Enqueue a Greeter job'
  task :enqueue do
    Resque.enqueue(Greeter, 'World')
  end
end

namespace :ping do
  desc 'Enqueue a Ping job'
  task :enqueue do
    Resque.enqueue(Ping)
  end
end

desc 'Run Redis examples'
task :redis_eg do
  require 'lib/redis_eg'
  RedisEg.run
end

#---[ fin ]-------------------------------------------------------------
