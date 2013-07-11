Feature: users asks a question

  A user is prompted to ask a new question, his/her answer and the party who needs to answer the question.

    Background:
      Given I am a logged in user

    Scenario: User is prompted for a question
      When I click on the "New Question" menu item
      Then I should see a form
        And the form should have a "Question" input field
        And the form should have a "Your answer" input field
        And the form should have a "Invitations" input group

    Scenario: User creates a question with no question text
      When I create a new question
        And I click on the "Create Question" button
      Then I should see an error that question cannot be blank

    Scenario: User creates a question with no answer text
      When I create a new question
        And I enter a question text
        And I click on the "Create Question" button
      Then I should see an error that the answer cannot be blank

    Scenario: User creates a question with no invitations
      When I create a new question
        And I enter a question text
        And I enter an answer
        And I click on the "Create Question" button
      Then I should see an error that at least one invitation is required

    Scenario: User adds a new invitee while creating a new question
      When I create a new question
        And I click on the "Add" link
      Then I should see two invitations

    Scenario: User removes an invitee while creating a new question
      When I create a new question
        And I click on the "Remove" icon by an invitation
      Then I should see that invitation disappear
