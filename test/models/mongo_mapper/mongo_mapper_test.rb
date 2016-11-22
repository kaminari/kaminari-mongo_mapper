# frozen_string_literal: true
require 'test_helper'

class MongoMapperExtensionTest < ActiveSupport::TestCase
  setup do
    begin
      MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
      MongoMapper.database = "kaminari_test"
      class MongoMapperExtensionDeveloper
        include ::MongoMapper::Document
        key :salary, Integer
      end
    rescue Mongo::ConnectionFailure
      pending 'can not connect to MongoDB'
    end
  end

  setup do
    MongoMapperExtensionDeveloper.destroy_all
    41.times { MongoMapperExtensionDeveloper.create!({salary: 1}) }
  end

  sub_test_case '#page' do
    test 'page 1' do
      developers = MongoMapperExtensionDeveloper.page(1)

      assert_kind_of Plucky::Query, developers
      assert_equal 1, developers.current_page
      assert_equal 25, developers.limit_value
      assert_equal 2, developers.total_pages
      assert_equal 0, developers.instance_variable_get('@options')[:skip]
    end

    test 'page 2' do
      developers = MongoMapperExtensionDeveloper.page(2)

      assert_kind_of Plucky::Query, developers
      assert_equal 2, developers.current_page
      assert_equal 25, developers.limit_value
      assert_equal 2, developers.total_pages
      assert_equal 25, developers.instance_variable_get('@options')[:skip]
    end

    test 'page "foobar"' do
      developers = MongoMapperExtensionDeveloper.page 'foobar'

      assert_kind_of Plucky::Query, developers
      assert_equal 1, developers.current_page
      assert_equal 25, developers.limit_value
      assert_equal 2, developers.total_pages
      assert_equal 0, developers.instance_variable_get('@options')[:skip]
    end

    test 'with criteria before' do
      # should have the proper criteria source
      assert_equal({salary: 1}, MongoMapperExtensionDeveloper.where(salary: 1).page(2).criteria.source)

      developers = MongoMapperExtensionDeveloper.where(salary: 1).page 2

      assert_equal 2, developers.current_page
      assert_equal 25, developers.limit_value
      assert_equal 2, developers.total_pages
      assert_equal 25, developers.instance_variable_get('@options')[:skip]
    end

    test 'with criteria after' do
      # should have the proper criteria source
      assert_equal({salary: 1}, MongoMapperExtensionDeveloper.where(salary: 1).page(2).criteria.source)

      developers = MongoMapperExtensionDeveloper.page(2).where(salary: 1)

      assert_equal 2, developers.current_page
      assert_equal 25, developers.limit_value
      assert_equal 2, developers.total_pages
      assert_equal 25, developers.instance_variable_get('@options')[:skip]
    end
  end

  test '#per' do
    developers = MongoMapperExtensionDeveloper.page(2).per(10)

    assert_kind_of Plucky::Query, developers
    assert_equal 2, developers.current_page
    assert_equal 10, developers.limit_value
    assert_equal 5, developers.total_pages
    assert_equal 10, developers.instance_variable_get('@options')[:skip]
  end
end
