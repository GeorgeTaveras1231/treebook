class StatusesController < ApplicationController
  before_action :verify_user
  
  expose(:user){ current_user }
  expose(:all_statuses, model: :status){ Status.all }
  expose(:current_status){ current_status_strategy }
 

  def create
    respond_to do |format|
      if current_status.save
        format.html { redirect_to statuses_path, notice: "Saved status!" }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if current_status.update_attributes(status_params)
        format.html { redirect_to statuses_path, notice: "Updated" }
      else
        format.html { render action: 'edit' }
      end
    end
  end   

  def destroy
    current_status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_path }
    end
  end

  private

    def current_status_strategy
      status = Status.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        status = user.statuses.new
      ensure
        status.update_attributes(status_params) if params[:status]
    end

    def verify_user
      unless current_status.belongs_to? user
        redirect_to user, alert: "Tsk tsk, how dare you!"
      end
    end

    def status_params
      params.require(:status).permit(:content)
    end
end
