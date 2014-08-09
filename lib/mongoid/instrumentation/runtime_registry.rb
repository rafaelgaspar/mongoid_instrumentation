module Mongoid
  module Instrumentation
    class RuntimeRegistry
      extend ActiveSupport::PerThreadRegistry

      attr_accessor :db_runtime

      [:db_runtime].each do |val|
        class_eval %{ def self.#{val}; instance.#{val}; end }, __FILE__, __LINE__
        class_eval %{ def self.#{val}=(x); instance.#{val}=x; end }, __FILE__, __LINE__
      end
    end
  end
end
