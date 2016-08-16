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

    rand = rand(0..99999).to_s

    @login = "user_#{rand}_#{time}" # This variable is used for 'register_user' and 'login_user' methods

    @project_name = "My project #{rand}_#{time}" # This variable is used for - 'create_project' method

    @project_link = "my-project-#{rand}_#{time}" # This variable is used for - 'create_project' method

    @version_name = "Version #{rand}" # This variable is used for - 'test_create_project_version' test

    @add_user = 'Matt Walker'  # This variable is used for - 'add_member' method
  end

  def test_register_positive
    register_user

    expected_text = 'Ваша учётная запись активирована. Вы можете войти.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_change_password_positive
    register_user

    @driver.find_element(:class, 'my-account').click
    @driver.find_element(:link, 'Change password').click
    @driver.find_element(:id, 'password').send_keys 'epyfnm'
    @driver.find_element(:id, 'new_password').send_keys 'epyfnm3epyfnm'
    @driver.find_element(:id, 'new_password_confirmation').send_keys 'epyfnm3epyfnm'
    @driver.find_element(:name, 'commit').click

    @wait.until {@driver.find_element(:id, 'flash_notice').displayed?}

    expected_text = 'Password was successfully updated.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_change_password_to_empty_negative
    register_user

    @driver.find_element(:class, 'my-account').click
    @driver.find_element(:link, 'Change password').click
    @wait.until {@driver.find_element(:id, 'password').displayed?}
    @driver.find_element(:name, 'commit').click

    @wait.until {@driver.find_element(:id, 'flash_error').displayed?}

    expected_text = 'Wrong password'
    actual_text = @driver.find_element(:id, 'flash_error').text
    assert_equal(expected_text, actual_text)
  end

  # login_logout

  def test_login
    register_user

    login_user

    user_active = @driver.find_element(:link, "#{@login}")
    assert(user_active.displayed?)
  end

  def test_login_with_empty_data_negative
    @driver.navigate.to 'http://demo.redmine.org/'

    @wait.until {@driver.find_element(:class, 'login').displayed?}

    @driver.find_element(:class, 'login').click

    @wait.until {@driver.find_element(:id, 'username').displayed?}

    @driver.find_element(:name, 'login').click

    @wait.until {@driver.find_element(:id, 'flash_error').displayed?}

    expected_text = 'Неправильное имя пользователя или пароль'
    actual_text = @driver.find_element(:id, 'flash_error').text
    assert_equal(expected_text, actual_text)
  end

  def test_log_out
    register_user

    login_user

    @driver.find_element(:class, 'logout').click

    login_button = @driver.find_element(:class, 'login')
    assert(login_button.displayed?)

    assert_equal('http://demo.redmine.org/', @driver.current_url)
  end

  # project

  def test_create_project
    register_user

    create_project

    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_add_user_to_the_project 
    register_user

    create_project

    @driver.find_element(:id, 'tab-members').click

    @wait.until {@driver.find_element(:link, 'New member').displayed?}

    @driver.find_element(:link, 'New member').click

    @wait.until {@driver.find_element(:id, 'principal_search').displayed?}

    @driver.find_element(:id, 'principal_search').send_keys @add_user

    @wait.until {@driver.find_element(:css, '#principals input').displayed?}
    
    @driver.find_element(:css, '#principals input').click
    @driver.find_element(:css, '.roles-selection input[value="4"]').click
    @driver.find_element(:id, 'member-add-submit').click

    @wait.until {@driver.find_element(:class, 'even').displayed?}
    
    @driver.find_element(:css, '.even .roles').text.include? 'Developer'

    assert_equal("http://demo.redmine.org/projects/#{@project_link}-identifier/settings/members", @driver.current_url)
  end

  def test_edit_user_roles
    register_user

    create_project

    add_member

    @driver.find_element(:css, '.even .icon-edit').click

    @wait.until {@driver.find_element(:css, "input[value='4']").displayed?}

    @driver.find_element(:css, "input[value='4']").click
    @driver.find_element(:css, "input[value='5']").click
    @driver.find_element(:css, ".even input[value='Save']").click

    @driver.find_element(:css, '.even .roles').text.include? 'Manager, Developer, Reporter'

    assert_equal("http://demo.redmine.org/projects/#{@project_link}-identifier/settings/members", @driver.current_url)
  end

  def test_create_project_version
    register_user

    create_project

    @driver.find_element(:id, 'tab-versions').click

    @wait.until {@driver.find_element(:link, 'New version').displayed?}

    @driver.find_element(:link, 'New version').click

    @wait.until {@driver.find_element(:id, 'version_name').displayed?}
    
    @driver.find_element(:id, 'version_name').send_keys @version_name

    @driver.find_element(:id, 'version_description').send_keys "Some description for this version"
    @driver.find_element(:name, 'commit').click

    @wait.until {@driver.find_element(:id, 'flash_notice').displayed?}

    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)    
  end

  # issue

  def test_issue_bug
    register_user

    create_project

    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys "Button 'Create' is not displayed on main page"
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this bug'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:name, 'commit').click

    notice = @driver.find_element(:id, 'flash_notice')
    assert(notice.displayed?)
  end

  def test_issue_feature
    register_user

    create_project

    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:id, 'issue_tracker_id').displayed?}

    @driver.find_element(:css,'#issue_tracker_id option[value="2"]').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys 'Add new functions for create issues'
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this feature'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:css,'#issue_priority_id option[value="5"]').click
    @driver.find_element(:name, 'commit').click

    notice = @driver.find_element(:id, 'flash_notice')
    assert(notice.displayed?)
  end

  def test_issue_support
    register_user

    create_project

    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:id, 'issue_tracker_id').displayed?}

    @driver.find_element(:css,'#issue_tracker_id option[value="3"]').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys 'Suppor issue'
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this support issue'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:css,'#issue_priority_id option[value="7"]').click
    @driver.find_element(:name, 'commit').click

    notice = @driver.find_element(:id, 'flash_notice')
    assert(notice.displayed?)
  end

  def test_issues_visible
    register_user

    create_project

    issue_bug

    issue_feature

    issue_support

    @driver.find_element(:class, 'issues').click

    bug = @driver.find_element(:link, "Button 'Create' is not displayed on main page")
    assert(bug.displayed?)

    feature = @driver.find_element(:link, "Add new functions for create issues")
    assert(feature.displayed?)

    support = @driver.find_element(:link, "Suppor issue")
    assert(support.displayed?)
  end

  def teardown
    @driver.quit
  end

end
