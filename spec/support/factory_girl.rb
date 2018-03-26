RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include RequestSpecHelper
  config.include ControllerSpecHelper
end
