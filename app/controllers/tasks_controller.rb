class TasksController < ApplicationController
  def index
    @tasks = Tasks.all
  end

  def new
    @task = Tasks.new
  end
end
