module FakeDelete
  module Core
    def self.included(base)
      base.send :extend, Query
    end

    module Query
      def fake_delete?
        true
      end

      def only_deleted
        scoped.tap { |x| x.default_scoped = false }.where("#{self.table_name}.deleted <> 0")
      end

      def with_deleted
        scoped.tap { |x| x.default_scoped = false }
      end
    end

    def destroy
      run_callbacks(:destroy) { delete }
    end

    def delete
      return if new_record? || destroyed?
      update_column :deleted, Time.now.to_i
    end

    def recover
      update_column :deleted, 0
    end

    def destroyed?
      self.deleted != 0
    end
    alias :deleted? :destroyed?
  end
end
