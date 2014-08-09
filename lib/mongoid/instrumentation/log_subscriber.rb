require "mongoid/instrumentation/runtime_registry"

module Mongoid
  module Instrumentation
    class LogSubscriber < ActiveSupport::LogSubscriber
      def self.runtime=(value)
        Mongoid::Instrumentation::RuntimeRegistry.db_runtime = value
      end

      def self.runtime
        Mongoid::Instrumentation::RuntimeRegistry.db_runtime ||= 0
      end

      def self.reset_runtime
        rt, self.runtime = runtime, 0
        rt
      end

      def initialize
        super
      end

      def query(event)
        self.class.runtime += event.duration
      end

      def logger
        Mongoid.logger
      end
    end
  end
end

Mongoid::Instrumentation::LogSubscriber.attach_to :moped
Mongoid::Instrumentation::LogSubscriber.attach_to :mongoid
