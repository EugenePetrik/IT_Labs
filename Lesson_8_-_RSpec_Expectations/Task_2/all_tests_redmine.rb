require 'test/unit'
require 'selenium-webdriver'
require 'rspec'
require_relative 'our_module_redmine'

class AllTestsRedmine < Test::Unit::TestCase

  include OurModuleRedmine

  include RSpec::Matchers

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)

    time = DateTime.parse(Time.now.to_s).strftime("%d_%m_%Y_%H_%M")

    rand = rand(0..99999).to_s

    @login = "user_#{rand}_#{time}"

    @email = "user_#{rand}_#{time}@gmail.com"

    @project_name = "My project #{rand}_#{time}"

    @project_link = "my-project-#{rand}_#{time}"

    @version_name = "Version #{rand}"

    @add_user = 'Matt Walker'

    @version_date = DateTime.parse((Time.now + 1.days).to_s).strftime("%Y-%m-%d")

    @bug_subject = "Button 'Create' is not displayed on main page"

    @bug_description = "Some description for this bug"

    @feature_subject = "Add new functions for create issues"

    @feature_description = "Some description for this feature"

    @support_subject = "Suppor issue"

    @support_description = "Some description for this support issue"
  end

  def test_register_positive
    open_readmine_and_click_register

    register_user(@login, @email)

    expect(@driver.find_element(:id, 'flash_notice').text).to eq('Ваша учётная запись активирована. Вы можете войти.')
  end

  def test_register_with_empty_data_negative
    open_readmine_and_click_register

    @driver.find_element(:name, 'commit').click

    expect(@driver.find_element(:id, 'errorExplanation').displayed?).to be_true
  end

  def test_change_password_positive
    open_readmine_and_click_register

    register_user(@login, @email)

    change_password('qwerty', 'qwerty3qwerty', 'qwerty3qwerty')

    expect(@driver.find_element(:id, 'flash_notice').text).to eq('Password was successfully updated.')
  end

  def test_change_password_with_different_new_pass_and_confirm_pass_negative
    open_readmine_and_click_register

    register_user(@login, @email)

    change_password('qwerty', 'qwerty3', 'qwerty3qwerty')

    expect(@driver.find_element(:id, 'errorExplanation').text).to eq("Password doesn't match confirmation")
  end

  def test_change_password_to_empty_negative
    open_readmine_and_click_register

    register_user(@login, @email)

    change_password('', '', '')

    expect(@driver.find_element(:id, 'flash_error').text).to eq('Wrong password')
  end

  # login_and_logout

  def test_login_positive
    open_readmine_and_click_register

    register_user(@login, @email)

    logout_user

    login_user(@login)

    expect(@driver.find_element(:link, "#{@login}")).to eq(@login)
  end

  def test_login_with_empty_data_negative
    open_readmine_and_click_register

    login_user('', '')

    expect(@driver.find_element(:id, 'flash_error').text).to eq('Неправильное имя пользователя или пароль')
  end

  def test_register_and_logout
    open_readmine_and_click_register

    register_user(@login, @email)

    logout_user

    expect(@driver.current_url).to eq('http://demo.redmine.org/')
  end

  def test_register_login_and_logout
    open_readmine_and_click_register

    register_user(@login, @email)

    logout_user

    login_user(@login)

    logout_user

    expect(@driver.current_url).to eq('http://demo.redmine.org/')
  end

  # project

  def test_create_project
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    expect(@driver.find_element(:id, 'flash_error').text).to eq('Successful creation.')
  end

  def test_add_user_to_the_project 
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    add_member_to_project(@add_user)

    expect(@driver.find_element(:css, '.even .roles').text.include? 'Developer').to be true
    
    expect(@driver.current_url).to eq('http://demo.redmine.org/projects/#{@project_link}-identifier/settings/members')
  end

  def test_edit_user_roles
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    add_member_to_project(@add_user)

    @driver.find_element(:css, '.even .icon-edit').click
    @driver.find_element(:css, ".even input[value='4']").click
    @driver.find_element(:css, ".even input[value='5']").click
    @driver.find_element(:css, ".even input[value='Save']").click

    expect(@driver.find_element(:css, '.even .roles').text.include? 'Manager, Developer, Reporter').to be true

    expect(@driver.current_url).to eq('http://demo.redmine.org/projects/#{@project_link}-identifier/settings/members')
  end

  def test_create_project_version
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    add_project_version(@version_name, 'Some description for this version', @version_date)

    expect(@driver.find_element(:id, 'flash_notice').text).to eq('Successful creation.') 
  end

  # issue

  def test_issue_bug
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    create_issue_bug(@bug_subject, @bug_description)

    expect(@driver.find_element(:id, 'flash_notice')).to exist
  end

  def test_issue_feature
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    create_issue_feature(@feature_subject, @feature_description)

    expect(@driver.find_element(:id, 'flash_notice')).to exist
  end

  def test_issue_support
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    create_issue_support(@support_subject, @support_description)

    expect(@driver.find_element(:id, 'flash_notice')).to exist
  end

  def test_issues_visible
    open_readmine_and_click_register

    register_user(@login, @email)

    create_project(@project_name)

    create_issue_bug(@bug_subject, @bug_description)

    create_issue_feature(@feature_subject, @feature_description)

    create_issue_support(@support_subject, @support_description)

    @driver.find_element(:class, 'issues').click

    expect(@driver.find_element(:link, "Button 'Create' is not displayed on main page").text).to eql("Button 'Create' is not displayed on main page")

    expect(@driver.find_element(:link, "Add new functions for create issues").text).to eql("Add new functions for create issues")

    expect(@driver.find_element(:link, "Suppor issue").text).to eql("Suppor issue")
  end

  def teardown
    @driver.quit
  end

end