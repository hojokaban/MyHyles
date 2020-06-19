include ApplicationHelper
class HyleDailyRelationshipsController < ApplicationController

  before_action :set_hyle_daily_relationship

  def create
    @daily_relationship = DailyRelationship.find(params[:daily_relationship_id])
    if HyleDailyRelationship.find_by(hyle_id:params[:hyle_daily_relationship][:hyle_id],
                          daily_relationship_id:params[:daily_relationship_id])
      flash.now[:danger] = "このヒュレーはすでに存在します"
    else
      @hyle_daily_relationship_tobe_saved = HyleDailyRelationship.new(relationship_params)
      @hyle_daily_relationship_tobe_saved.daily_relationship = @daily_relationship
      if @hyle_daily_relationship_tobe_saved.save
        @hyle_daily_relationship_tobe_saved.hyle.set_relationship(@hyle_daily_relationship_tobe_saved)
      else
        flash.now[:danger]=set_error_flash(@hyle_daily_relationship_tobe_saved)
      end
    end
      render template: 'daily_relationships/new'
  end

  def destroy
    @hyle_daily_relationship_tobe_destroyed = HyleDailyRelationship.find(params[:daily_relationship_id])
    @daily_relationship = @hyle_daily_relationship_tobe_destroyed.daily_relationship
    @hyle_daily_relationship_tobe_destroyed.hyle.delete_relationship(@hyle_daily_relationship_tobe_destroyed)
    @hyle_daily_relationship_tobe_destroyed.destroy
    flash[:success] = "ヒュレーを削除しました"
    render template: 'daily_relationships/new'
  end

  private

    def relationship_params
      params.require(:hyle_daily_relationship).permit(:hyle_id,:relationship_amount)
    end

    def set_hyle_daily_relationship
      @hyle_daily_relationship = HyleDailyRelationship.new
    end
end
