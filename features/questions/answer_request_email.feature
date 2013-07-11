Feature: an answer request email is sent

  Background:
    Given I am a logged in user

  Scenario: a proper answer request email gets sent
    When I create a question with invitiation to "example@example.com"
    Then I should see "Request for Answer sent in email" message
      And "example@example.com" should receive 1 email
    When "example@example.com" opens the email with subject "Answer this question!"
      And they follow "here" in the email
    Then they should see the associated answer form
