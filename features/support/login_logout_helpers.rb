module LoginLogoutHelpers

  def login_user
    fetch_visitor
    user_find_or_create(@visitor)
    visit '/users/sign_in'
    fill_in "user_email", :with => @visitor[:email]
    fill_in "user_password", :with => @visitor[:password]
    click_button "Sign me in"
  end

  def logout_user
    page.driver.submit :delete, "/sign_out", {}
  end

  def logout
    logout_user
  end

protected
  def fetch_visitor
    @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
      :password => "changeme", :password_confirmation => "changeme" }
  end

  def user_find_or_create(attribs)
    @user = User.find_by_email(attribs[:email]) rescue nil
    @user = User.create(attribs) if @user.blank?
  end
end

class Cucumber::Rails::World
  include LoginLogoutHelpers
end
