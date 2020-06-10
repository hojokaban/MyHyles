class LabelsController < ApplicationController

  def edit
    @hyle = Hyle.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

end
