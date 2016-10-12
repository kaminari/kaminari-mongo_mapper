# frozen_string_literal: true
require 'kaminari/mongo_mapper/plucky_criteria_methods'

module Kaminari
  module MongoMapper
    module MongoMapperExtension
      module Document
        extend ActiveSupport::Concern
        include Kaminari::ConfigurationMethods

        included do
          # Fetch the values at the specified page number
          #   Model.page(5)
          scope Kaminari.config.page_method_name, Proc.new {|num|
            limit(default_per_page).offset(default_per_page * ([num.to_i, 1].max - 1))
          }
        end
      end
    end
  end
end
