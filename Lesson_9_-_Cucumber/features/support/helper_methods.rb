module OurRedmine
  def login_user(name, pass='qwerty')
    @driver.find_element(class: 'login').click
    @wait.until { @driver.find_element(id: 'username').displayed? }
    @driver.find_element(id: 'username').send_keys name
    @driver.find_element(id: 'password').send_keys pass
    @driver.find_element(name: 'login').click
    @wait.until { @driver.find_element(id: 'loggedas').displayed? }
  end

  def register_user(login, email, firstname='Matt', lastname='Walker')
    @driver.find_element(class: 'register').click
    @driver.find_element(id: 'user_login').send_keys login
    @driver.find_element(id: 'user_password').send_keys 'qwerty'
    @driver.find_element(id: 'user_password_confirmation').send_keys 'qwerty'
    @driver.find_element(id: 'user_firstname').send_keys firstname
    @driver.find_element(id: 'user_lastname').send_keys lastname
    @driver.find_element(id: 'user_mail').send_keys email
    @driver.find_element(css: '#user_language option[value="en-GB"]').click
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end

  def logout_user
    @driver.find_element(class: 'logout').click
    @wait.until { @driver.find_element(tag_name: 'h1').displayed? }
  end

  def change_password(pass, new_pass, pass_confirm)
    @driver.find_element(class: 'my-account').click
    @driver.find_element(link: 'Change password').click
    @wait.until { @driver.find_element(id: 'password').displayed? }
    @driver.find_element(id: 'password').send_keys pass
    @driver.find_element(id: 'new_password').send_keys new_pass
    @driver.find_element(id: 'new_password_confirmation').send_keys pass_confirm
    @driver.find_element(name: 'commit').click
  end

  def create_project(name, iden='-identifier')
    @driver.find_element(class: 'projects').click
    @wait.until { @driver.find_element(link: 'New project').displayed? }
    @driver.find_element(link: 'New project').click
    @wait.until { @driver.find_element(id: 'project_name').displayed? }
    @driver.find_element(id: 'project_name').send_keys name
    @driver.find_element(id: 'project_identifier').send_keys iden
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end

  def add_member_to_project(user)
    @driver.find_element(id:'tab-members').click
    @wait.until { @driver.find_element(link: 'New member').displayed? }
    @driver.find_element(link: 'New member').click
    @wait.until { @driver.find_element(id: 'principal_search').displayed? }
    @driver.find_element(id: 'principal_search').send_keys user
    sleep(2)
    @wait.until { @driver.find_element(css: '#principals input').displayed? }
    @driver.find_element(css: '#principals input').click
    @driver.find_element(css: '.roles-selection input[value="4"]').click
    @driver.find_element(id: 'member-add-submit').click
    @wait.until { @driver.find_element(class: 'even').displayed? }
  end

  def add_project_version(version, descr, date)
    @driver.find_element(id: 'tab-versions').click
    @wait.until { @driver.find_element(link: 'New version').displayed? }
    @driver.find_element(link: 'New version').click
    @wait.until { @driver.find_element(id: 'version_name').displayed? }
    @driver.find_element(id: 'version_name').send_keys version
    @driver.find_element(id: 'version_description').send_keys descr
    @driver.find_element(id: 'version_effective_date').send_keys date
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end

  def create_issue_bug(subj, descr)
    @driver.find_element(class: 'new-issue').click
    @wait.until { @driver.find_element(id: 'issue_subject').displayed? }
    @driver.find_element(id: 'issue_subject').send_keys subj
    @driver.find_element(id: 'issue_description').send_keys descr
    @driver.find_element(css: '#issue_status_id option[value="2"]').click
    @driver.find_element(css: '#issue_priority_id option[value="5"]').click
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end

  def create_issue_feature(subj, descr)
    @driver.find_element(class: 'new-issue').click
    @wait.until { @driver.find_element(id: 'issue_subject').displayed? }
    @driver.find_element(css: '#issue_tracker_id option[value="2"]').click
    @wait.until { @driver.find_element(id: 'issue_subject').displayed? }
    @driver.find_element(id: 'issue_subject').send_keys subj
    @driver.find_element(id: 'issue_description').send_keys descr
    @driver.find_element(css: '#issue_status_id option[value="2"]').click
    @driver.find_element(css: '#issue_priority_id option[value="5"]').click
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end

  def create_issue_support(subj, descr)
    @driver.find_element(class: 'new-issue').click
    @wait.until { @driver.find_element(id: 'issue_subject').displayed? }
    @driver.find_element(css: '#issue_tracker_id option[value="3"]').click
    @wait.until { @driver.find_element(id: 'issue_subject').displayed? }
    @driver.find_element(id: 'issue_subject').send_keys subj
    @driver.find_element(id: 'issue_description').send_keys descr
    @driver.find_element(css: '#issue_status_id option[value="2"]').click
    @driver.find_element(css: '#issue_priority_id option[value="7"]').click
    @driver.find_element(name: 'commit').click
    @wait.until { @driver.find_element(id: 'flash_notice').displayed? }
  end
end

World(OurRedmine)