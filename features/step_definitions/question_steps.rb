Given /^I am a logged in user$/ do
  login_user
end

Given /^I have created a question$/ do
  steps %Q{
      Given I am a logged in user
      And I create a new question
      And I fill in the question form
      And I click on the "Create Question" button
    }
end

When /^I create a new question$/ do
  click_link 'New Question'
end

When /^I click on the "([^\"]*)" menu item$/ do |menu_item|
  click_link menu_item
end

When /^I click on the "([^\"]*)" link$/ do |link|
  click_link link
end

When /^I click on the "([^\"]*)" button$/ do |button|
  click_button button
end

When /^I enter a question text$/ do
  fill_in("Question", :with => "How far is the Moon?")
end

When /^I enter an answer$/ do
  fill_in("Your answer", :with => "some 400,000 kms")
end

When /^I fill in the question form$/ do
  fill_in("Question", :with => "How far is the Moon?")
  fill_in("Your answer", :with => "some 400,000 kms")
  fill_in("Email", :with => "example@example.com")
end

When /^I click on the "Remove" icon by an invitation$/ do
  find('form#new_question div.control-group.email a.js-remove-nested-item').click
end

When /^I click on the "Details" link of a question$/ do
  link = find('a', text: "Details")
  id = link['href'].split('/').last
  @question = Question.find(id)
  link.click
end

Then /^I should see a form$/ do
  page.should have_selector('form#new_question')
  @question_form = find('form#new_question')
end

Then /^the form should have a "([^\"]*)" input field$/ do |field_name|
  @question_form.should have_selector("label", text: field_name, visible: true)
end

Then /^the form should have a "([^\"]*)" input group$/ do |field_name|
  @question_form.should have_selector("legend", text: field_name, visible: true)
end

Then /^I should see an error that question cannot be blank$/ do
  page.should have_selector('#flash_alert')
  @alert = find('#flash_alert')
  @alert.should have_content('You have to enter a question')
end

Then /^I should see an error that the answer cannot be blank$/ do
  page.should have_selector('#flash_alert')
  @alert = find('#flash_alert')
  @alert.should have_content('You have to enter an answer')
end

Then /^I should see an error that at least one invitation is required$/ do
  page.should have_selector('#flash_alert')
  @alert = find('#flash_alert')
  @alert.should have_content('You have to invite at least one person')
end

Then /^I should see two invitations$/ do
  pending "It is implemented with JavaScript; no way to test here"
end

Then /^I should see that invitation disappear$/ do
  pending "It is implemented with JavaScript; no way to test here"
end

Then /^I should see the table of questions that I created$/ do
  page.should have_content("Questions You Asked")
  page.should have_selector('table#questions')
  @table = find('table#questions')
end

Then /^the table should have (?:an?) "([^\"]*)" column$/ do |column_name|
  column_name = column_name.downcase.gsub(/ /,'-')
  @table.should have_selector("thead th.#{column_name}")
end

Then /^each table content row should have "([^\"]*)" link$/ do |link_title|
  @table.all(:css, 'tbody tr').each do |row|
    row.should have_link(link_title)
  end
end

Then /^I should see the related "Question"$/ do
  page.should have_content(@question.text)
end

Then /^I should see the related "Status"$/ do
  page.should have_selector('.status')
end

Then /^I should see the related list of Answers$/ do
  page.should have_selector('table#answers')
  answers = find('table#answers')
  answers.all(:cs, 'tbody tr').count.should == @question.answers.count
end

