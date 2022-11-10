class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks =  current_user.tasks.page(params[:page]).per(2)
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.search_title(params[:task][:title]).search_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.search_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.search_status(params[:task][:status])
      elsif params[:task][:label_id].present?
        @tasks = @tasks.joins(:labels).where(labels: { id: params[:task][:label_id] })
      end
    end

    if params[:sort_expired]
      @tasks = @tasks.order(deadline: :desc)
    elsif params[:sort_priority_high]
      @tasks = @tasks.order(priority: :asc)
    else
      @tasks = @tasks.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, { label_ids: [] })
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
