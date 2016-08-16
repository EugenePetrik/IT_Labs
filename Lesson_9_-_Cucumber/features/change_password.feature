Feature: Change password

  Background: on Main Page
    Given I am on Main Page

  @positive @change_pass
  Scenario: Positive change password
    When I am change password to another
    Then I am get message, that password is changed

  @negative @change_pass
  Scenario: Negative change password
    When I fill not valid password
    Then there is notice

  @negative @change_pass
  Scenario: Negative change password
    When I fill empty passwords
    Then there is notice error