Feature: Login

  Background: on Main Page
    Given I am on Main Page

  @positive @log_in
  Scenario: Positive Login
    When I am submit valid credentials login and password
    Then I am logged in

  @negative @log_in
  Scenario Outline: Negative Login
    When I submit not valid credentials "<login>"/"<password>"
    Then there is error message "<message>"

    Examples:
      | login | password | message                  |
      |       |          | Invalid user or password |
      | qqqqq |          | Invalid user or password |
      |       | qqqqqq   | Invalid user or password |
      | qqqqq | qqqqqq   | Invalid user or password |