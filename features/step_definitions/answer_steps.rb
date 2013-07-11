When /^I create a question with invitiation(?:s*) to "([^\"]*)"$/ do |email_list|
  click_link 'New Question'

  @question = "How far is the Moon?"
  @email = email_list.split(",").first
  fill_in("Question", :with => @question)
  fill_in("Your answer", :with => "some 400,000 kms")
  fill_in("Email", :with => email_list)

  click_button "Create Question"
end

When /^they save "([^\"]*)" as an answer$/ do |answer|
  @answer = answer
  fill_in("Your answer", :with => answer)
  find('form#answer input[type="submit"]').click
end

When /^I click on the "Details" link of an answer$/ do
  link = first('a', text: "Details")
  id = link['href'].split('/').last
  @question = Question.find(id)
  link.click
end

Then /^(?:I|they) should see "([^\"]*)" message$/ do |message|
  page.should have_content message
end

Then /^(?:I|they) should see the associated answer form$/ do
  page.should have_content(@question)
  page.should have_content(@email)
  page.should have_selector('form#answer')
  @answer_form = find('form#answer')
end

Then /^I should see the table of answers that I created$/ do
  page.should have_content("My Answers")
  page.should have_selector('table#answers')
  @table = find('table#answers')
end

Then /^I should see the answer's question's details$/ do
  page.should have_content(@question.text)
  page.should have_selector('.status')
  page.should have_selector('table#answers')
end

Then /^they should see all answers$/ do
  page.should have_content(@question)
  page.should have_selector('table#answers')
  answers = find('table#answers')
  answers.all(:cs, 'tbody tr').count.should == 2
end

Then /^they should see their own answer only$/ do
  page.should have_content(@question)
  page.should_not have_selector('table#answers')
  page.should have_content(@answer)
end