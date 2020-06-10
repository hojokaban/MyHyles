include ApplicationHelper
class HylesController < ApplicationController

  def new
      @hyle = Hyle.new
      @category = Category.new
  end

  def create
    @hyle = current_user.hyles.new(hyle_params)
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid?
    if @hyle.save
      flash[:success] = "ヒュレーが追加されました!"
      redirect_to users_hyles_path
    else
      flash[:danger] = set_error_flash(@hyle)
      @category = Category.new
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
  end

  def categorized_index
  end

  def tagged_index
  end

  def update
  end

  def destroy
  end

  private

    def hyle_params
      params.require(:hyle).permit(:category_id, :name,
         :birthday_added, :birthday, :hyle_image, :tag_list)
    end

end
