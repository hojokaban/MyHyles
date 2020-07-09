require 'active_support/core_ext/time'
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development

def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

set :chronic_options, hours24: true
set :environment, rails_env
set :output, 'log/cron.log'
# ENV.each { |k, v| env(k, v) }
every 1.day, at: jst('0:00') do
    begin
        runner "Batch::Relationship.relationship"
    rescue => e
        Rails.logger.error("aborted rails runner")
        raise e
    end
end
