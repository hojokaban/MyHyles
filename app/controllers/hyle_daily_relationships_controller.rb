include ApplicationHelper
class HyleDailyRelationshipsController < ApplicationController

  def create
    @hyle_daily_relationship = HyleDailyRelationship.new(relationship_params)
    flash[:danger]=set_error_flash(@hyle_daily_relationship) unless @hyle_daily_relationship.create
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end

  private

    def relationship_params
      params.require(:hyle_daily_relationship).permit(:hyle_id,
                      :daily_relationship_id, :relationship_amount)
    end
end
