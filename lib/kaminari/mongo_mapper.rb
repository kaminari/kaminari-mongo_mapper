require "kaminari/mongo_mapper/version"
require 'kaminari/core'
require 'mongo_mapper'

require 'kaminari/mongo_mapper/mongo_mapper_extension'
::MongoMapper::Document.send :include, Kaminari::MongoMapper::MongoMapperExtension::Document
::Plucky::Query.send :include, Kaminari::MongoMapper::PluckyCriteriaMethods
