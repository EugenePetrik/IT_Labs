Feature: Logout

  Background: on Main Page
    Given I am on Main Page
    And I am authorized

  @positive @log_out
  Scenario: Positive Logout
    When I am want to logout
    Then I am logout