module OurModule

  def register_user
    @driver.navigate.to 'http://demo.redmine.org/'

    @wait.until {@driver.find_element(:class, 'register').displayed?}

    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @driver.find_element(:id, 'user_login').send_keys @login
    @driver.find_element(:id, 'user_password').send_keys 'epyfnm'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'epyfnm'
    @driver.find_element(:id, 'user_firstname').send_keys 'Matt'
    @driver.find_element(:id, 'user_lastname').send_keys 'Walker'
    @driver.find_element(:id, 'user_mail').send_keys(@login + '@gmail.com')
    @driver.find_element(:css,'#user_language option[value="en-GB"]').click
    @driver.find_element(:name, 'commit').click

    @wait.until {@driver.find_element(:id, 'flash_notice').displayed?}
  end

  def login_user
    @driver.navigate.to 'http://demo.redmine.org/'

    @wait.until {@driver.find_element(:class, 'login').displayed?}

    @driver.find_element(:class, 'login').click

    @wait.until {@driver.find_element(:id, 'username').displayed?}

    @driver.find_element(:id, 'username').send_keys @login
    @driver.find_element(:id, 'password').send_keys 'epyfnm'
    @driver.find_element(:name, 'login').click

    @wait.until {@driver.find_element(:class, 'logout').displayed?}
  end

  def issue_bug
    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys "Button 'Create' is not displayed on main page"
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this bug'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:name, 'commit').click
  end

  def issue_feature
    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:css,'#issue_tracker_id option[value="2"]').displayed?}

    @driver.find_element(:css,'#issue_tracker_id option[value="2"]').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys 'Add new functions for create issues'
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this feature'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:css,'#issue_priority_id option[value="5"]').click
    @driver.find_element(:name, 'commit').click
  end

  def issue_support
    @driver.find_element(:class, 'new-issue').click

    @wait.until {@driver.find_element(:css,'#issue_tracker_id option[value="3"]').displayed?}

    @driver.find_element(:css,'#issue_tracker_id option[value="3"]').click

    @wait.until {@driver.find_element(:id, 'issue_subject').displayed?}

    @driver.find_element(:id, 'issue_subject').send_keys 'Suppor issue'
    @driver.find_element(:id, 'issue_description').send_keys 'Some description for this support issue'
    @driver.find_element(:css,'#issue_status_id option[value="2"]').click
    @driver.find_element(:css,'#issue_priority_id option[value="7"]').click
    @driver.find_element(:name, 'commit').click
  end

end