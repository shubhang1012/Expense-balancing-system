require 'bundler/setup'

# Disable Bootsnap in Render's lightweight container
begin
  require 'bootsnap/setup' unless ENV['DISABLE_BOOTSNAP']
rescue LoadError
  puts "Bootsnap disabled"
end
