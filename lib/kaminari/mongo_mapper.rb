require "kaminari/mongo_mapper/version"

ActiveSupport.on_load :mongo_mapper do
  require 'kaminari/models/mongo_mapper_extension'
  ::MongoMapper::Document.send :include, Kaminari::MongoMapperExtension::Document
  ::Plucky::Query.send :include, Kaminari::PluckyCriteriaMethods
end
