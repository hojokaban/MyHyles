require 'active_support/core_ext/time'

def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

set :chronic_options, hours24: true
# Learn more: http://github.com/javan/whenever
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
set :environment, rails_env
set :output, 'log/cron.log'
every 1.day, at: jst('0:00') do
    begin
        runner "Batch::Relationship.relationship"
    rescue => e
        Rails.logger.error("aborted rails runner")
        raise e
    end
end
