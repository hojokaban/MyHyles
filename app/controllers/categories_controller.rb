include ApplicationHelper
class CategoriesController < ApplicationController

    def create
        @category = current_user.categories.new(category_params)
        if @category.save
            flash[:success] = "カテゴリーが追加されました"
        else
            flash[:danger] = set_error_flash(@category)
        end
        redirect_back(fallback_location: root_path)
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
        else
            flash[:danger] = set_error_flash(@category)
        end
        redirect_back(fallback_location: root_path)
    end

    def destroy
    end

    private

        def category_params
            params.require(:category).permit(:name)
        end
end
