require "kaminari/mongo_mapper/version"
require 'kaminari'
require 'mongo_mapper'

require 'kaminari/mongo_mapper/mongo_mapper_extension'
::MongoMapper::Document.send :include, Kaminari::MongoMapperExtension::Document
::Plucky::Query.send :include, Kaminari::PluckyCriteriaMethods
