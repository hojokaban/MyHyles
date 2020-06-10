include ApplicationHelper
class LabelsController < ApplicationController

  def edit
    @label = Label.new
    @hyle = Hyle.find(params[:id])
  end

  def create
    @label = current_user.labels.new(label_params)
    @label.save ? flash[:success]="ラベルが追加されました" : flash[:danger]=set_error_flash(@label)
    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
  end

  private

    def label_params
      params.require(:label).permit(:hyle_id, :name, :body)
    end

end
