include ApplicationHelper
class UsersController < ApplicationController

  def show
    @q = current_user.hyles.ransack(params[:q])
    @today = Date.current
    days_later = days_later_date(@today, current_user.notice_before)
    if (@today + current_user.notice_before).year != @today.year
      @birthday_hyles = current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                "1231", today_date(@today)).order(:birthday_date)
      @birthday_hyles += current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                days_later, "0101").order(:birthday_date)
    else
      @birthday_hyles = current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                days_later, today_date(@today)).order(:birthday_date)
    end
    @relationship_hyles = current_user.hyles.order(:total_relationship).first(3)
  end

  def update
    current_user.tag_list.remove(params[:tag])
    current_user.update(tag_list: current_user.tag_list)
    flash[:success] = "タグが削除されました"
    redirect_back(fallback_location: root_path)
  end
end
