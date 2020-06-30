class DailyRelationshipsController < ApplicationController

  before_action :permitted_user, only: [:new]

  def new
    @daily_relationship = current_user.daily_relationships.create!
    @hyle_daily_relationship = HyleDailyRelationship.new
  end

  def update
    @daily_relationship = DailyRelationship.find(params[:id])
    unless current_user.id == 2
      if @daily_relationship.hyle_daily_relationships.present?
        current_user.hyles.each{ |hyle| hyle.set_relationship }
        current_user.set_relationship_percentage
        current_user.update(has_done: true)
        flash[:success] = "今日の関係が追加されました!"
        redirect_to users_path
      else
        flash[:danger] = "ヒュレーを最低１人追加してください"
        redirect_back(fallback_location: root_path)
      end
    else
      @daily_relationship.destroy
      flash[:success] = "デモユーザーでは登録、編集、削除はできません"
      redirect_to users_path
    end
  end

  private

    def permitted_user
      if current_user.has_done
        flash[:danger] = "今日の関係は記録済みです"
        redirect_to users_path
      end
    end

end
