require "fake_delete/core"

module FakeDelete
  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def fake_delete
      include Core

      default_scope { where(deleted: 0) }
    end

    def fake_delete?
      false
    end
  end

  module InstanceMethods
    def fake_delete?
      self.class.fake_delete?
    end

    def persisted?
      fake_delete? ? !new_record? : super
    end
  end
end
