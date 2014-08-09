module Mongoid
  module Instrumentation
    class Railtie < Rails::Railtie
      # Expose mongoid runtime to controller for logging.
      initializer "mongoid.log_runtime" do
        require "mongoid/instrumentation/railties/controller_runtime"
        ActiveSupport.on_load(:action_controller) do
          include Mongoid::Instrumentation::Railties::ControllerRuntime
        end
      end
    end
  end
end
