# frozen_string_literal: true
DatabaseCleaner[:mongo_mapper].strategy = :truncation

class ActiveSupport::TestCase
  class << self
    def startup
      DatabaseCleaner.clean_with :truncation
      super
    end
  end

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end
end
