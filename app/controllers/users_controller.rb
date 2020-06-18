class UsersController < ApplicationController
  def show
  end

  def update
    current_user.tag_list.remove(params[:tag])
    current_user.update(tag_list: current_user.tag_list)
    flash[:success] = "タグが削除されました"
    redirect_back(fallback_location: root_path)
  end
end
