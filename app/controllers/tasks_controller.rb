class TasksController < ApplicationController
  def index
    if params[:sort_expired]
      @tasks = Task.page(params[:page]).per(5).order('deadline ASC')
    elsif params[:pri_sort]
      @tasks = Task.page(params[:page]).per(5).order('priority ASC')
    else
      @tasks = Task.page(params[:page]).per(5).order('created_at DESC')
    end
  end

  def search
    @search_params = task_search_params
    @tasks = Task.page(params[:page]).per(5).searchh(@search_params)
      render :index
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
    redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status, :priority)
    .merge(status: params[:task][:status].to_i).merge(priority: params[:task][:priority].to_i)
  end

  def task_search_params
    params.fetch(:search, {}).permit(:name, :status)
  end
end
