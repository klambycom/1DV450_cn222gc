module OmniAuth
  module Strategies
    autoload :ToerhDoorkeeper, 'lib/toerh_doorkeeper_strategy'
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :toerh_doorkeeper, "98540e836d1cb2ea0c0a6e2258bcbd3efec7fc22ef7c7d8b31745d192706fe3c", "5d66848f57b977d76272b79193eece090687515095201e285635e49e4efa3245"
end
