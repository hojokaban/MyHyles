include ApplicationHelper
class HylesController < ApplicationController

  before_action :set_hyle, only: [:show, :edit, :update, :destroy]

  def new
      @hyle = Hyle.new
      @category = Category.new
  end

  def create
    @hyle = current_user.hyles.new(hyle_params)
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid? && params[:hyle][:tag_list].present?
    if @hyle.save
      flash[:success] = "ヒュレーが追加されました!"
      redirect_to edit_users_label_path(@hyle)
    else
      flash[:danger] = set_error_flash(@hyle)
      @category = Category.new
      redirect_to new_users_hyle_path
    end
  end

  def show
  end

  def edit
    @label = Label.new
  end

  def update
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid? && params[:hyle][:tag_list].present?
    @hyle.update(hyle_params) ? flash[:success]="ヒュレーが編集されました!" : flash[:danger]=set_error_flash(@hyle)
    redirect_back(fallback_location: root_path)
  end

  def index
    @title = "全ヒュレー"
    @hyles = current_user.hyles
  end

  def categorized_index
    @title = "カテゴリー別ヒュレー"
    @hyles = Category.find(params[:id]).hyles
    render :index
  end

  def tagged_index
    @title = "タグ別ヒュレー"
    @hyles = current_user.hyles.tagged_with(params[:id])
    render :index
  end

  def destroy
    @hyle.destroy
    flash[:success]="ヒュレーを削除しました"
    redirect_to users_hyles_path
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
