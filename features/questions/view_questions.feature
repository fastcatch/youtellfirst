Feature: users displays the questions she created
  A user is given a list of questions along with status about answers.
  Elements of the list contain questions and answers in more detail.
    Background:
      Given I have created a question
    Scenario: User displays the list of questions
      When I click on the "My Questions" menu item
      Then I should see the table of questions that I created
        And the table should have a "Question" column
        And the table should have an "Answers" column
        And the table should have a "Status" column
        And the table should have an "Asked At" column
        And each table content row should have "Details" link

    Scenario: User views the details of a question she asked
      When I click on the "My Questions" menu item
        And I click on the "Details" link of a question
      Then I should see the related "Question"
        And I should see the related "Status"
        And I should see the related list of Answers