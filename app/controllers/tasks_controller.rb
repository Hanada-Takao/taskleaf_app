class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only:[:edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.page(params[:page]).per(5).order('deadline ASC')
    elsif params[:pri_sort]
      @tasks = current_user.tasks.page(params[:page]).per(5).order('priority ASC')
    else
      @tasks = current_user.tasks.page(params[:page]).per(5).order('created_at DESC')
    end
  end

  def search
    @search_params = task_search_params
    @tasks = current_user.tasks.page(params[:page]).per(5).searchh(@search_params)
      render :index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
    redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      if params[:task][:tag_ids].present?
        @task.task_tags.each do |task_tag|
          task_tag.destroy if task_tag.task_id == @task.id
        end
        params[:task][:tag_ids].each do |tag_id|
          TaskTag.create(task_id: @task.id, tag_id: tag_id)
        end
      else
        @task.task_tags.each do |task_tag|
          task_tag.destroy if task_tag.task_id == @task.id
        end
      end
    else
      @task_tag_ids = @task.tags_attached_to_task.pluck(:id)
      render "edit"
    end
    redirect_to task_path(@task.id), notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status, :priority, { tag_ids: [] })
    .merge(status: params[:task][:status].to_i).merge(priority: params[:task][:priority].to_i)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:name, :status)
  end
end
