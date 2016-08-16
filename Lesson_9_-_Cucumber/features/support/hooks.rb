Before do
  @driver = Selenium::WebDriver.for :firefox
  @wait = Selenium::WebDriver::Wait.new(timeout:10)
end

After do
  @driver.quit
end