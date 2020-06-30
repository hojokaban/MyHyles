include ApplicationHelper
class CategoriesController < ApplicationController
  before_action :prohabit_demo_user, only: [:create, :update, :destroy]

  def create
    @category = current_user.categories.new(category_params)
    @category.save ? flash.now[:success] = "カテゴリーが追加されました" :flash.now[:danger] = set_error_flash(@category)
    @categories = current_user.categories.where.not(id: nil)
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params) ? flash.now[:success] = "カテゴリーが編集されました": flash.now[:danger] = set_error_flash(@category)
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash.now[:success] = "カテゴリーが削除されました"
  end

  private
    def category_params
        params.require(:category).permit(:name)
    end
end
