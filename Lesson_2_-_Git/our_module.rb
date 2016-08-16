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
end