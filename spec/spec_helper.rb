require 'capybara/rspec'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'capybara/mechanize'

appHostUrl = ENV["TEST_URL"] || "http://127.0.0.1:1337"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

Capybara.configure do |config|
  config.run_server = false
  config.app = 'app_4_mechanize'
  config.app_host = appHostUrl
  config.default_driver = :mechanize
  config.javascript_driver = :selenium
  config.default_wait_time = 30
end

Capybara.register_driver :selenium do |app|
  require 'selenium/webdriver'
  Selenium::WebDriver::Firefox::Binary.path = "/opt/firefox/firefox"
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

def has_js
  return Capybara.current_driver == Capybara.javascript_driver
end

# Public: Wait while the predicate defined by block 
# is not satisfied by repeatedly
# calling the block until it returns true.
#
# Useful to wait for external systems to do something.
# Like launching daemons in integration tests. Which 
# you're not actually doing right? >_<
#
# timeout        - Integer specifying how many seconds
#                  to wait for.
# retry_interval - Interval in seconds between
#                  calling block while it's
#                - returning false.
# block          - A block which returns true or false.
#                  It should only return true when
#                  there no need to wait any more.
#
# Returns false if timeout reached before block returned
# true, otherwise it returns true.

def wait_until(timeout = 30, retry_interval = 0.1, &block)
  start = Time.now
  while (result = !block.call)
    break if (Time.now - start).to_i >= timeout
    sleep(retry_interval)
  end
  !result
end

def on_page(url, &block)
  wait_until do
    current_path.include? url
  end
  current_path.should have_content(url)
  block.call
end

