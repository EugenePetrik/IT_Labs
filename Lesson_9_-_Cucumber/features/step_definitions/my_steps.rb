auth_login = "matt_walker"

bug_subject = "Button 'Create' is not displayed on main page"
bug_description = "Some description for this bug"


bug_subject = "Button 'Create' is not displayed on main page"
bug_description = "Some description for this bug"

feature_subject = "Add new functions for create issues"
feature_description = "Some description for this feature"

support_subject = "Suppor issue"
support_description = "Some description for this support issue"


# Steps for login

Given(/^I am on Main Page$/) do
  @driver.navigate.to 'http://demo.redmine.org/'
  @wait.until { @driver.find_element(tag_name: 'h1').displayed? }
end

When(/^I am submit valid credentials login and password$/) do
  login_user(auth_login, pass='qwerty')
end

Then(/^I am logged in$/) do
  @wait.until { @driver.find_element(id: 'loggedas').displayed? }
  # expect(@driver.find_element(id:'loggedas').text).not_to be_nil
  expect(@driver.find_element(class: 'active').text).to eql auth_login
end

When(/^I submit not valid credentials "([^"]*)"\/"([^"]*)"$/) do |login, password|
  @driver.find_element(class: 'login').click
  @wait.until { @driver.find_element(id: 'username').displayed? }
  @driver.find_element(id: 'username').send_keys login
  @driver.find_element(id: 'password').send_keys password
  @driver.find_element(name: 'login').click
end

Then(/^there is error message "([^"]*)"$/) do |message|
  @wait.until {@driver.find_element(id: 'flash_error').displayed?}
  expect(@driver.find_element(id: 'flash_error').text).to eql message
end


# Steps register

When(/^I am submit valid credentials for registration$/) do
  register_user("user_#{rand(0..99999).to_s}", "user_#{rand(0..99999).to_s}@gmail.com")
end

Then(/^I am registered user$/) do
  expect(@driver.find_element(id: 'flash_notice').text).to eql('Your account has been activated. You can now log in.')
end

When(/^I am submit not valid credentials for registration$/) do
  @driver.find_element(class: 'register').click
  @driver.find_element(name: 'commit').click
  @wait.until { @driver.find_element(id: 'errorExplanation').displayed? }
end

Then(/^there is error explanation$/) do
  expect(@driver.find_element(id: 'errorExplanation').displayed?).to be true
end

When(/^I submit registration form with$/) do |table|
  hash = table.hashes

  hash.each do |row|
    row.each_pair do |key, value|
      @driver.find_element(class: 'register').click
      @driver.find_element(id: key).send_keys value
      @driver.find_element(id: key).send_keys value
      @driver.find_element(id: key).send_keys value
      @driver.find_element(id: key).send_keys value
      @driver.find_element(id: key).send_keys value
      @driver.find_element(id: key).send_keys value
      @driver.find_element(name: 'commit').click
    end
  end
end

Then(/^I get the error message "<flash_notice>"$/) do |message|
  expect(@driver.find_element(id: 'flash_notice').text).to eql message
end


# Steps logout

And(/^I am authorized$/) do
  login_user(auth_login, pass='qwerty')
end

When(/^I am want to logout$/) do
  logout_user
end

Then(/^I am logout$/) do
  expect(@driver.current_url).to eql('http://demo.redmine.org/')
end


# Steps change password

When(/^I am change password to another$/) do
  register_user("user_#{rand(0..99999).to_s}", "user_#{rand(0..99999).to_s}@gmail.com")
  change_password('qwerty', 'qwertyqwerty', 'qwertyqwerty')
end

Then(/^I am get message, that password is changed$/) do
  @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  expect(@driver.find_element(id: 'flash_notice').text).to eql('Password was successfully updated.')
end

When(/^I fill not valid password$/) do
  register_user("user_#{rand(0..99999).to_s}", "user_#{rand(0..99999).to_s}@gmail.com")
  change_password('qwerty', 'qwerty3', 'qwerty3qwerty')
end

Then(/^there is notice$/) do
  @wait.until {@driver.find_element(id:'errorExplanation').displayed?}
  expect(@driver.find_element(id:'errorExplanation').text).to eql("Password doesn't match confirmation")
end

When(/^I fill empty passwords$/) do
  login_user(auth_login, pass='qwerty')
  change_password('', '', '')
end

Then(/^there is notice error$/) do
  @wait.until {@driver.find_element(id:'flash_error').displayed?}
  expect(@driver.find_element(id:'flash_error').text).to eql("Wrong password")
end


# Steps create project

When(/^I create new project$/) do
  rand_create_project = rand(0..99999).to_s
  register_user("user_#{rand_create_project}", "user_#{rand_create_project}@gmail.com")
  create_project("My project #{rand_create_project}")
end

Then(/^project created$/) do
  expect(@driver.find_element(id:'flash_notice').text).to eql('Successful creation.')
end

When(/^I add user to the project$/) do
  rand_add_user = rand(0..99999).to_s
  register_user("user_#{rand_add_user}", "user_#{rand_add_user}@gmail.com")
  create_project("My project #{rand_add_user}")
  add_member_to_project('Matt Walker')
end

Then(/^user added$/) do
  expect(@driver.find_element(css: '.even .roles').text.include? 'Developer').to be true
end

When(/^I change roles for the project$/) do
  rand_change_role = rand(0..99999).to_s
  register_user("user_#{rand_change_role}", "user_#{rand_change_role}@gmail.com", 'Alex', 'Ravi')
  create_project("My project #{rand_change_role}")
  add_member_to_project('Matt Walker')
  @driver.find_element(css: '.even .icon-edit').click
  @driver.find_element(css: ".even input[value='3']").click
  @driver.find_element(css: ".even input[value='5']").click
  @driver.find_element(css: ".even .small").click
  @wait.until { @driver.find_element(css: '.even .roles span').displayed? }
end

Then(/^roles edited$/) do
  expect(@driver.find_element(css: '.even .roles span').text).to eql('Manager, Developer, Reporter')
end

When(/^I create new version for the project$/) do
  rand_project_version = rand(0..99999).to_s
  version_name = "Version #{rand}"
  version_descr = 'Some description for this version'
  version_date = DateTime.parse((Time.now).to_s).strftime("%Y-%m-%d")
  register_user("user_#{rand_project_version}", "user_#{rand_project_version}@gmail.com")
  create_project("My project #{rand_project_version}")
  add_project_version(version_name, version_descr, version_date)
end

Then(/^version created$/) do
  expect(@driver.find_element(id: 'flash_notice').text).to eql('Successful creation.')
end


# Steps create issue

When(/^I create new bug$/) do
  bug_user = rand(0..99999).to_s
  register_user("user_#{bug_user}", "user_#{bug_user}@gmail.com")
  create_project("My project #{bug_user}")
  create_issue_bug(bug_subject, bug_description)
end

Then(/^bug created$/) do
  expect(@driver.find_element(id: 'flash_notice')).to be_truthy
end

When(/^I create new feature$/) do
  feature_user = rand(0..99999).to_s
  register_user("user_#{feature_user}", "user_#{feature_user}@gmail.com")
  create_project("My project #{feature_user}")
  create_issue_feature(feature_subject, feature_description)
end

Then(/^feature created$/) do
  expect(@driver.find_element(id: 'flash_notice')).to be_truthy
end

When(/^I create new support$/) do
  support_user = rand(0..99999).to_s
  register_user("user_#{support_user}", "user_#{support_user}@gmail.com")
  create_project("My project #{support_user}")
  create_issue_support(support_subject, support_description)
end

Then(/^support created$/) do
  expect(@driver.find_element(id: 'flash_notice')).to be_truthy
end

When(/^I create all type issues$/) do
  issue_user = rand(0..99999).to_s
  register_user("user_#{issue_user}", "user_#{issue_user}@gmail.com")
  create_project("My project #{issue_user}")
  create_issue_bug(bug_subject, bug_description)
  create_issue_feature(feature_subject, feature_description)
  create_issue_support(support_subject, support_description)
  @driver.find_element(class: 'issues').click
  @wait.until { @driver.find_element(tag_name: 'h2').displayed? }
end

Then(/^all type issues created$/) do
  expect(@driver.find_element(link: "Button 'Create' is not displayed on main page")).to be_truthy
  expect(@driver.find_element(link: "Add new functions for create issues")).to be_truthy
  expect(@driver.find_element(link: "Suppor issue")).to be_truthy
end