After do |scenario|
  #Cucumber.wants_to_quit = true if scenario.failed?
  save_and_open_page if scenario.failed?
end