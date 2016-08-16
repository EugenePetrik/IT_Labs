Feature: Registration

  Background: on Main Page
    Given I am on Main Page

  @positive @reg
  Scenario: Positive registration
    When I am submit valid credentials for registration
    Then I am registered user

  @negative @reg
  Scenario: Negative registration with empty all fields
    When I am submit not valid credentials for registration
    Then there is error explanation

  @negative @reg
  Scenario: Negative registration with some empty param
    When I submit registration form with

      | user_login | user_password | user_password_confirmation | user_firstname | user_lastname | user_mail      | flash_notice                        |
      |            | qwerty        | qwerty                     | Matt           | Walker        | email@mail.com | Login cannot be blank               |
      | matt_user  | qwerty        | qwerty3                    | Matt           | Walker        | email@mail.com | Password doesn't match confirmation |
      | matt_user  | qwerty        | qwerty                     |                | Walker        | email@mail.com | First name cannot be blank          |
      | matt_user  | qwerty        | qwerty                     | Matt           |               | email@mail.com | Last name cannot be blank           |
      | matt_user  | qwerty        | qwerty                     | Matt           | Walker        | email@mail.com | Email cannot be blank               |

    Then I get the error message "<flash_notice>"