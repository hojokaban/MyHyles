include ApplicationHelper
class MemoriesController < ApplicationController

  before_action :set_memory, only: [:show, :edit, :update, :destroy]

  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.new(memory_params)
    if @memory.save
      @memory.set_hyle_memory(params[:memory][:hyle_ids])
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
    if @memory.update(memory_params)
      @memory.set_hyle_memory(params[:memory][:hyle_ids])
      flash[:success] = "思い出が編集されました!"
      redirect_to users_memory_path(@memory)
    else
      flash[:danger] = set_error_flash(@memory)
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @memories = current_user.memories
  end

  def destroy
    @memory.destroy
    flash[:success] = "思い出が削除されました"
    redirect_to users_memories_path
  end

  private

    def memory_params
      params.require(:memory).permit(:title, :date, :description, :memory_image)
    end

    def set_memory
      @memory = Memory.find(params[:id])
    end

end
