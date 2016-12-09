# encoding: utf-8

require 'spec_helper'
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'headless'


shared_examples_for "standard happy path" do

  headless = Headless.new(display: 99, autopick: true, reuse: false, destroy_at_exit: true).start

  it "confirms app is functioning correctly" do

    visit '/'
    # Verify-apostille
    fill_in('ApostDay', :with => ENV['TEST_DAY'])
    fill_in('ApostMonth', :with => ENV['TEST_MONTH'])
    fill_in('ApostYear', :with => ENV['TEST_YEAR'])
    fill_in('ApostNumber', :with => ENV['TEST_REFERENCE'])
    click_on 'Verify'

    # details
    page.should have_content('Apostille verified')
    page.should have_content('Apostille number')
    page.should have_content('Date of issue')
    page.should have_content('Has been signed by')
    page.should have_content('Acting in the capacity of')
    page.should have_content('Bears the stamp / seal of')
    page.should have_content('Issued by')

  end

end

describe "standard service happy path", :type => :feature do
  context "with js", :js => true do
    it_should_behave_like "standard happy path"
  end
end
