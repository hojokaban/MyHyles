include ApplicationHelper
class CategoriesController < ApplicationController

    def create
        @category = current_user.categories.new(category_params)
        @category.save ? flash[:success] = "カテゴリーが追加されました" :
            flash[:danger] = set_error_flash(@category)
        redirect_back(fallback_location: root_path)
    end

    def update
        @category = Category.find(params[:id])
        @category.update(category_params) ? flash[:success] = "カテゴリーが編集されました"
                : flash[:danger] = set_error_flash(@category)
        redirect_back(fallback_location: root_path)
    end

    def destroy
        Category.find(params[:id]).destroy
        flash[:success] = "カテゴリーが削除されました"
        redirect_back(fallback_location: root_path)
    end

    private

        def category_params
            params.require(:category).permit(:name)
        end
end
