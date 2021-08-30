class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort] == "due"
      @tasks = current_user.tasks.order(due_date: :desc).page(params[:page])
    elsif params[:sort] == "priority"
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page])
    else
      @tasks = current_user.tasks.default_order.page(params[:page])
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
    @task = current_user.tasks.build(task_params)
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
    @tasks = @tasks.where(user_id: current_user.id)
    labels_param = params[:labels]
    if labels_param['label_id'].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: labels_param['label_id'] })
    end
    render :index
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :due_date, :status, :priority, { label_ids: [] })
  end

end
