require 'spec_helper'
require 'pry'
require 'custom_fragment_cache'

describe CustomFragmentCache do
  class DummyClass
    include CustomFragmentCache::Logic
  end

  describe "#expire_cache?" do
    context "safe fields" do
      it "returns true when some non safe field changed" do
        cache = Object.new
        cache.stub(:fields_method) { :safe }
        cache.stub(:fields) { ["a"] }
        resource = Object.new
        resource.stub(:changed) { ["a", "b"] }
        DummyClass.new.expire_cache?(cache, resource).should be_true
      end

      it "returns false when only safe fields changed" do
        cache = Object.new
        cache.stub(:fields_method) { :safe }
        cache.stub(:fields) { ["a", "b"] }
        resource = Object.new
        resource.stub(:changed) { ["a", "b"] }
        DummyClass.new.expire_cache?(cache, resource).should be_false
      end
    end

    context "trigger fields" do
      it "returns true when some of the trigger fields changed" do
        cache = Object.new
        cache.stub(:fields_method) { :trigger }
        cache.stub(:fields) { ["a"] }
        resource = Object.new
        resource.stub(:changed) { ["a", "b", "c"] }
        DummyClass.new.expire_cache?(cache, resource).should be_true
      end

      it "returns false when none of the trigger fields changed" do
        cache = Object.new
        cache.stub(:fields_method) { :trigger }
        cache.stub(:fields) { ["x", "y"] }
        resource = Object.new
        resource.stub(:changed) { ["a", "b", "c"] }
        DummyClass.new.expire_cache?(cache, resource).should be_false
      end
    end
  end
end