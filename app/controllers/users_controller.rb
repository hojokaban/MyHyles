include ApplicationHelper
class UsersController < ApplicationController

  def show
    today = today_date
    days_later = days_later_date(today, current_user.notice_before)
    if today.to_i >= 1201 && today.to_i <= 1231
      @birthday_hyles = current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                "1231", today).order(:birthday_date)
      @birthday_hyles += current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                days_later, "0101").order(:birthday_date)
    else
      @birthday_hyles = current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
                days_later, today).order(:birthday_date)
    end
  end

  def update
    current_user.tag_list.remove(params[:tag])
    current_user.update(tag_list: current_user.tag_list)
    flash[:success] = "タグが削除されました"
    redirect_back(fallback_location: root_path)
  end
end
