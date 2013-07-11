RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
  config.include ControllerMacros::InstanceMethods, :type => :controller
end
