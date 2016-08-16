require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'

class TestRegistration < Test::Unit::TestCase

  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)

    time = Time.now.to_s
    time = DateTime.parse(time).strftime("%d_%m_%Y_%H_%M")

    rand = rand(0..9999).to_s

    @login = "user_#{rand}_#{time}" # This variable is used for 'register_user' and 'login_user' methods

    @project_name = "My project #{rand}_#{time}" # This variable is used for - 'create_project' method
  end

  def test_create_project
    register_user

    create_project

    random_action = rand(0..1)

    if random_action
        issue_bug
    end

    @driver.find_element(:class, 'issues').click

    if @driver.find_element(:css, "tr[id^='issue-']").displayed?
        @driver.find_element(:css, "a[href^='/issues/']").click

        @wait.until {@driver.find_element(:tag_name, 'h2').displayed?}

        @driver.find_element(:link, 'Watch').click
    else
        issue_bug

        @driver.find_element(:css, "a[href^='/issues/']").click

        @wait.until {@driver.find_element(:tag_name, 'h2').displayed?}

        @driver.find_element(:link, 'Watch').click        
    end

    @wait.until {@driver.find_element(:link, "Unwatch").displayed?}

    user_watch = @driver.find_element(:link, "Unwatch")
    assert(user_watch.displayed?)
  end

  def teardown
    @driver.quit
  end

end