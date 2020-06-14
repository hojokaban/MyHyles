include ApplicationHelper
class HyleDailyRelationshipsController < ApplicationController

  def create
    @daily_relationship = DailyRelationship.find(params[:daily_relationship_id])
    @hyle_daily_relationship = HyleDailyRelationship.new
    if HyleDailyRelationship.find_by(hyle_id:params[:hyle_daily_relationship][:hyle_id],
                          daily_relationship_id:params[:daily_relationship_id])
      flash.now[:danger] = "このヒュレーはすでに存在します"
    else
      @hyle_daily_relationship_tobe_saved = HyleDailyRelationship.new(relationship_params)
      @hyle_daily_relationship_tobe_saved.daily_relationship = @daily_relationship
      flash.now[:danger]=set_error_flash(@hyle_daily_relationship_tobe_saved) unless @hyle_daily_relationship_tobe_saved.save
    end
      render template: 'daily_relationships/new'
  end

  def destroy
    @hyle_daily_relationship_tobe_destroyed = HyleDailyRelationship.find(params[:daily_relationship_id])
    @daily_relationship = @hyle_daily_relationship_tobe_destroyed.daily_relationship
    @hyle_daily_relationship = HyleDailyRelationship.new
    @hyle_daily_relationship_tobe_destroyed.destroy
    flash[:success] = "ヒュレーを削除しました"
    render template: 'daily_relationships/new'
  end

  private

    def relationship_params
      params.require(:hyle_daily_relationship).permit(:hyle_id,:relationship_amount)
    end
end