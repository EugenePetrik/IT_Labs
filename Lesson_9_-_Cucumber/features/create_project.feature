Feature: Create project

  Background: on Main Page
    Given I am on Main Page

  @positive @create_project
  Scenario: Positive create project
    When I create new project
    Then project created

  @positive @create_project
  Scenario: Positive add user to the project
    When I add user to the project
    Then user added

  @positive @create_project
  Scenario: Positive change user roles
    When I change roles for the project
    Then roles edited

  @positive @create_project
  Scenario: Positive create project version
    When I create new version for the project
    Then version created