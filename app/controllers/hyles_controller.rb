include ApplicationHelper
class HylesController < ApplicationController

  before_action :set_hyle, only: [:show, :edit, :update]

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
      redirect_to new_users_hyle_path
    end
  end

  def show
    flash.now[:success] = "ヒュレーが追加されました!"
  end

  def edit
    @label = Label.new
  end

  def update
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

    def set_hyle
      @hyle = Hyle.find(params[:id])
    end

end
