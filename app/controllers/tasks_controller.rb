class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort] == "due"
      @tasks = Task.all.order(due_date: :desc).page(params[:page])
    elsif params[:sort] == "priority"
      @tasks = Task.all.order(priority: :desc).page(params[:page])
    else
      @tasks = Task.all.default_order.page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: %(Your New Task was successfully created)
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: %(Your Task was successfully updated)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: %(Your Task was deleted)
  end

  def search
    @tasks = Task.search(params[:search], params[:task]).default_order.page(params[:page])
    render :index
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :due_date, :status, :priority)
  end

end
