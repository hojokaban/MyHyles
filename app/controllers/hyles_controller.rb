include ApplicationHelper
class HylesController < ApplicationController

  def new
      @hyle = Hyle.new
      @category = Category.new
  end

  def create
    @hyle = current_user.hyles.new(hyle_params)
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid? && params[:hyle][:tag_list].present?
    if @hyle.save
      redirect_to edit_users_label_path(@hyle)
    else
      flash[:danger] = set_error_flash(@hyle)
      @category = Category.new
      render :new
    end
  end

  def show
    flash[:success] = "ヒュレーが追加されました!"
    @hyle = Hyle.find(params[:id])
  end

  def edit
    @hyle = Hyle.find(params[:id])
  end

  def update
    @hyle = Hyle.find(params[:id])
    @hyle.update(hyle_params) ? flash[:success]="ヒュレーが編集されました!" : flash[:danger]=set_error_flash(@hyle)
    redirect_back(fallback_location: root_path)
  end

  def index
  end

  def categorized_index
  end

  def tagged_index
  end

  def destroy
  end

  private

    def hyle_params
      params.require(:hyle).permit(:category_id, :name,
         :birthday_added, :birthday, :hyle_image, :tag_list)
    end

end
