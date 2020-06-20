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
    @hyle.set_birthday_date unless @hyle.birthday.nil?
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
    @hyles = current_user.hyles.paginate(page: params[:page], per_page: 10)
    @hyles_count = @hyles.count
    @hyle_type = "all"
  end

  def sort
    @title = "全ヒュレー"
    today = today_date(Date.current)
    birthday_hyles = current_user.hyles.where.not(birthday:nil).where('birthday_date >= ?', today).order(:birthday_date)
    birthday_hyles += current_user.hyles.where.not(birthday:nil).where('birthday_date < ?', today).order(:birthday_date)
    @hyles = birthday_hyles.paginate(page: params[:page], per_page: 10)
    @hyles_count = birthday_hyles.count
    @hyle_type = "birthday"
    render :index
  end

  def categorized_index
    @title = "カテゴリー別ヒュレー"
    @hyles = Category.find(params[:id]).hyles.paginate(page: params[:page], per_page: 10)
    @hyles_count = @hyles.count
    @hyle_type = "category"
    render :index
  end

  def tagged_index
    @title = "タグ別ヒュレー"
    @hyles = current_user.hyles.tagged_with(params[:id]).paginate(page: params[:page], per_page: 10)
    @hyles_count = @hyles.count
    render :index
  end

  def search
    @title = "「#{params[:term]}」の検索結果"
    @hyles = current_user.hyles.where("name LIKE?", "%#{params[:term]}%" ).paginate(page: params[:page], per_page: 10)
    @hyles_count = @hyles.count
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
