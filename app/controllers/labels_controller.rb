include ApplicationHelper
class LabelsController < ApplicationController
  before_action :prohabit_demo_user, only: [:create, :update, :destroy]

  def edit
    @label = Label.new
    @hyle = Hyle.find(params[:id])
  end

  def create
    @label = current_user.labels.new(label_params)
    @hyle = Hyle.find(params[:label][:hyle_id])
    @label.save ? flash.now[:success]="ラベルが追加されました" : flash.now[:danger]=set_error_flash(@label)
  end

  def update
    @label = Label.find(params[:id])
    @label.update(label_params) ? flash.now[:success]="ラベルが変更されました" : flash.now[:danger]=set_error_flash(@label)
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    flash.now[:success] = "ラベルが削除されました"
  end

  private

    def label_params
      params.require(:label).permit(:hyle_id, :name, :body)
    end

end
