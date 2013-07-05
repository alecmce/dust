#!/usr/bin/env ruby

HOME = File.dirname(__FILE__)
Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

dust = Dust.new HOME, 'config.yaml'

task :clean do
  dust.munit.clean
end

namespace :test do

  task :reset do
    puts dust.reset_tests
  end

  task :all => [:build, :clients]

  task :clients do
    puts dust.test %w(as3 js cpp)
  end

  task :as3 do
    puts dust.test %w(as3)
  end

  task :html5 do
    puts dust.test %w(js)
  end

  task :cpp do
    puts munit.test %w(cpp)
  end

  task :build do
    puts `(cd build && bundle exec rspec --fail-fast)`
  end

end

namespace :make do

  task :gem do
    gem build './rbhaxe.gemspec'
  end

  task :flash do
    dust.make 'flash'
  end

  task :html5 do
    dust.make 'html5'
  end

  task :iphone do
    dust.make 'iphone'
  end

  task :iphone_simulator do
    dust.make 'iphone_simulator'
  end

  task :ipad do
    dust.make 'ipad'
  end

  task :ipad_simulator do
    dust.make 'ipad_simulator'
  end

end

namespace :run do

  task :flash => :'make:flash' do
    dust.run 'flash'
  end

  task :html5 => :'make:html5' do

  end

  task :iphone => :'make:iphone' do
    dust.run 'ipad'
  end

  task :iphone_simulator => :'make:iphone_simulator' do
    dust.run 'iphone_simulator'
  end

  task :ipad => :'make:ipad' do
    dust.run 'ipad'
  end

  task :ipad_simulator => :'make:ipad_simulator' do
    dust.run 'ipad_simulator'
  end

end
