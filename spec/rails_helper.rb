require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
#メールのテスト用
require 'capybara/email/rspec'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # deprecationをエラーとして出力
  config.raise_errors_for_deprecations!
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  #テスト終了後にデータベースをきれいにする
  config.before(:suite) do
    DatabaseRewinder.clean_all
  end
  config.after(:each) do
    DatabaseRewinder.clean
  end

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.before(:each) do |example|
    if example.metadata[:type] == :system
      driven_by :selenium, using: :headless_chrome, screen_size: [1280, 800], options: { args: ["headless", "disable-gpu", "no-sandbox", "disable-dev-shm-usage"] }
    end
  end
  #メールのテスト用
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  #誕生日のテスト用
  config.include(ActiveSupport::Testing::TimeHelpers)
end
