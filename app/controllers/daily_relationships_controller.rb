class DailyRelationshipsController < ApplicationController

  def new
    @daily_relationship = current_user.daily_relationships.create!
    @hyle_daily_relationship = HyleDailyRelationship.new
  end

  def update
    @daily_relationship = DailyRelationship.find(params[:id])
    if @daily_relationship.hyle_daily_relationships.present?
      flash[:success] = "今日の関係が追加されました!"
      redirect_to users_path
    else
      flash[:danger] = "ヒュレーを最低１人追加してください"
      redirect_back(fallback_location: root_path)
    end
  end

end
