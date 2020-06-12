class DailyRelationshipsController < ApplicationController

  def new
    @daily_relationship = current_user.daily_relationships.create!
    @hyle_daily_relationship = HyleDailyRelationship.new
  end

  def create
  end

end
