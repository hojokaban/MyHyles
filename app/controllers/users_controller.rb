class UsersController < ApplicationController

  def show
    today = Date.today
    today_date = today.to_s[5..6] + today.to_s[8..10]
    month_later_date = (today_date.to_i + 100).to_s
    month_later_date.insert(0, "0") if month_later_date.length == 3
    month_later_date.slice(2..3).insert(0, "01") if month_later_date.slice(0..1) == "13"
    @hyles = current_user.hyles.where('birthday_date <= ? and birthday_date >= ?',
            month_later_date, today_date).order(:birthday_date)
  end

  def update
    current_user.tag_list.remove(params[:tag])
    current_user.update(tag_list: current_user.tag_list)
    flash[:success] = "タグが削除されました"
    redirect_back(fallback_location: root_path)
  end
end
