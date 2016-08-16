Feature: Create issues

  Background: on Main Page
    Given I am on Main Page

  @positive @create_issue
  Scenario: Positive create issue - bug
    When I create new bug
    Then bug created

  @positive @create_issue
  Scenario: Positive create issue - feature
    When I create new feature
    Then feature created

  @positive @create_issue
  Scenario: Positive create issue - support
    When I create new support
    Then support created

  @positive @create_issue_1
  Scenario: Positive create all type issues for one user
    When I create all type issues
    Then all type issues created