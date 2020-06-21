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
    @hyle_style = params[:q].nil? ? "": params[:q]["s"]
    @q = current_user.hyles.ransack(params[:q])
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @title = "全ヒュレー"
    @hyles_count = @hyles.count
  end

  # def sort_by_birthday
  #   @key = params[:key]
  #   @hyle_type = params[:id]
  #   hyles = find_hyles(@hyle_type, @key, current_user)
  #   @title = "全ヒュレー"
  #   today = today_date(Date.current)
  #   birthday_hyles = hyles.where.not(birthday:nil).where('birthday_date >= ?', today).order(:birthday_date)
  #   birthday_hyles += hyles.where.not(birthday:nil).where('birthday_date < ?', today).order(:birthday_date)
  #   @hyles = birthday_hyles.paginate(page: params[:page], per_page: 10)
  #   @hyles_count = birthday_hyles.count
  #   render :index
  # end

  def categorized_index
    @hyle_style = params[:q].nil? ? "": params[:q]["s"]
    @title = "カテゴリー別ヒュレー"
    @q = Category.find(params[:id]).hyles.ransack(params[:q])
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @hyles_count = @hyles.count
    render :index
  end

  def tagged_index
    @hyle_style = params[:q].nil? ? "": params[:q]["s"]
    @title = "タグ別ヒュレー"
    @q = current_user.hyles.tagged_with(params[:id]).ransack(params[:q])
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
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
