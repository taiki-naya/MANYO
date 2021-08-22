class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort] == "true"
      @tasks = Task.all.order(due_date: :desc)
    else
      @tasks = Task.all.default_order
    end
    @path = request.fullpath
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
    @tasks = Task.search(params[:search], params[:task]).default_order
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
