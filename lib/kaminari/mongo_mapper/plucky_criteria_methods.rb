# frozen_string_literal: true
module Kaminari
  module MongoMapper
    module PluckyCriteriaMethods
      include Kaminari::PageScopeMethods

      delegate :default_per_page, :max_per_page, :max_pages, to: :model

      def entry_name(options = {}) #:nodoc:
        model_name.human(options.reverse_merge(default: model_name.human.pluralize(options[:count])))
      end

      def limit_value #:nodoc:
        options[:limit]
      end

      def offset_value #:nodoc:
        options[:skip]
      end

      def total_count #:nodoc:
        count
      end
    end
  end
end
