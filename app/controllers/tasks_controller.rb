class TasksController < ApplicationController
  before_action :fetch_task, only: %i[edit update destroy toggle]

  def index
    @tasks = fetch_tasks

    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created' }
      else
        @tasks = fetch_tasks
        flash[:error] = @task.errors.full_messages

        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated' }
      else
        flash[:error] = @task.errors.full_messages

        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_url, notice: 'Post successfully deleted.'
    else
      redirect_to tasks_url, notice: 'Something went wrong.'
    end
  end

  def toggle
    if @task.update(completed: params[:completed])
      render json: { message: 'Task updated successfully' }
    else
      render json: { message: 'Task cannot be updated' }
    end
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def fetch_task
    @task = Task.find(params[:id])
  end

  def fetch_tasks
    Task.order(created_at: :desc)
  end
end
