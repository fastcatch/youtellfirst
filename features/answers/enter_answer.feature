Feature: an answer is eneterd in response to the request email

  Background:
    Given I am a logged in user

  Scenario: all answers are shown when the last answer is entered
    When I create a question with invitiation to "a@example.com"
      And "a@example.com" opens the email with subject "Answer this question!"
      And they follow "here" in the email
      And they save "500" as an answer
    Then they should see all answers

  Scenario: own answer is shown when the there are pending answers
    When I create a question with invitiations to "c@example.com, d@example.com"
      And "c@example.com" opens the email with subject "Answer this question!"
      And they follow "here" in the email
      And they save "500" as an answer
    Then they should see their own answer only
