Feature: all answers are distributed to all invitees (plus the originator) once all answers got received

  Scenario: an email is sent to users with the answers
    When I am a logged in user
      And I create a question with invitiation to "invitee@example.com"
      And "invitee@example.com" opens the email with subject "Answer this question!"
      And they follow "here" in the email
      And they save "500" as an answer
    Then they should see "Your answer was successfully saved." message
      And "example@example.com" should receive 1 email with subject /All answers/
      And "invitee@example.com" should receive 1 email with subject /All answers/
    When they open the email with subject /All answers/
    Then they should see "some 400,000 kms" in the email body
      And they should see "500" in the email body
