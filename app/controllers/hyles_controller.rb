include ApplicationHelper
class HylesController < ApplicationController

  before_action :set_hyle, only: [:show, :edit, :update, :destroy]
  before_action :prohabit_demo_user, only: [:create, :update, :destroy]

  def new
    @hyle = Hyle.new
    @category = Category.new
    @categories = current_user.categories
  end

  def create
    @hyle = current_user.hyles.new(hyle_params)
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid? && params[:hyle][:tag_list].present?
    unless @hyle.birthday.nil?
      @hyle.set_birthday_date
      @hyle.days_before(Date.current)
    end
    if @hyle.save
      flash[:success] = "ヒュレーが追加されました!"
      redirect_to edit_users_label_path(@hyle)
    else
      flash.now[:danger] = set_error_flash(@hyle)
      @category = Category.new
    end
  end

  def show
    @memories = @hyle.memories.order(date: :desc).paginate(page: params[:page], per_page: 20)
  end

  def edit
    @label = Label.new
    @categories = current_user.categories
  end

  def update
    @hyle.set_tag(params[:hyle][:tag_list]) if @hyle.valid? && params[:hyle][:tag_list].present?
    if @hyle.update(hyle_params)
      flash[:success] = "ヒュレーが編集されました!"
    else
      flash[:danger] = set_error_flash(@hyle)
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @hyle_style = params[:q].nil? ? "": params[:q]["s"].nil? ? "": params[:q]["s"]
    if @hyle_style.include?("birthday")
      @q = current_user.hyles.where.not(birthday:nil).ransack(params[:q])
    else
      @q = current_user.hyles.ransack(params[:q])
    end
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
    @title = "全ヒュレー"
    @hyles_count = @hyles.count
  end

  def categorized_index
    @hyle_style = params[:q].nil? ? "": params[:q]["s"].nil? ? "": params[:q]["s"]
    @title = "カテゴリー別ヒュレー"
    if @hyle_style.include?("birthday")
      @q = Category.find(params[:id]).hyles.where.not(birthday:nil).ransack(params[:q])
    else
      @q = Category.find(params[:id]).hyles.ransack(params[:q])
    end
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
    @hyles_count = @hyles.count
    render :index
  end

  def tagged_index
    @hyle_style = params[:q].nil? ? "": params[:q]["s"].nil? ? "": params[:q]["s"]
    @title = "タグ別ヒュレー"
    if @hyle_style.include?("birthday")
      @q = current_user.hyles.tagged_with(params[:id]).where.not(birthday:nil).ransack(params[:q])
    else
      @q = current_user.hyles.tagged_with(params[:id]).ransack(params[:q])
    end
    @hyles = @q.result(distinct: true).paginate(page: params[:page], per_page: 20)
    @hyles_count = @hyles.count
    render :index
  end

  def destroy
    @hyle.destroy
    flash[:success] = "ヒュレーを削除しました"
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
