include ApplicationHelper
class MemoriesController < ApplicationController

  before_action :set_memory, only: [:show]

  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.new(memory_params)
    if @memory.save
      flash[:success] = "思い出が追加されました!"
      redirect_to users_memory_path(@memory)
    else
      flash[:danger] = set_error_flash(@memory)
      redirect_back(fallback_location: root_path)
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def index
  end

  def destroy
  end

  private

    def memory_params
      params.require(:memory).permit(:title, :date, :description, :memory_image)
    end

    def hyle_memory_params
      params.require(:memory).permit(:hyle_id)
    end

    def set_memory
      @memory = Memory.find(params[:id])
    end

end
