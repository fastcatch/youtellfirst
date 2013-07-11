Feature: users displays the answers she created
  A user is given a list of answers with some details.  The questions are available via links.

    Background:
      Given I have created a question

    Scenario: User displays the list of answers
      When I click on the "My Answers" menu item
      Then I should see the table of answers that I created
        And the table should have a "Question" column
        And the table should have an "Originator" column
        And the table should have a "My Answer" column
        And the table should have a "Status" column
        And the table should have an "Asked At" column
        And each table content row should have "Details" link

    Scenario: User views the details of a question that she has answered
      When I click on the "My Answers" menu item
        And I click on the "Details" link of an answer
      Then I should see the answer's question's details