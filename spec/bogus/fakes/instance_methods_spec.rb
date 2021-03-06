require 'spec_helper'

module Bogus
  describe InstanceMethods do
    class SampleClass
      def foo(bar)
      end

      def hello
      end

      def self.bar(bam)
      end
    end

    let(:instance_methods) { InstanceMethods.new(SampleClass) }

    it "lists the instance methods" do
      expect(instance_methods.all).to match_array([:foo, :hello])
    end

    it "returns the instance methods by name" do
      expect(instance_methods.get(:foo)).to eq(
        SampleClass.instance_method(:foo))
    end

    it "removes methods by name" do
      instance_methods.remove(:hello)

      expect(SampleClass.new).to_not respond_to(:hello)
    end

    it "defines instance methods" do
      instance_methods.define <<-EOF
      def greet(name)
        return "Hello, " + name + "!"
      end
      EOF

      instance = SampleClass.new

      expect(instance.greet("Joe")).to eq "Hello, Joe!"
    end
  end
end
