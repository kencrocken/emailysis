class EmailsController < ApplicationController

  def new
    @email = Email.delay.email_fetch(session[:project], current_user.email, session[:token])

    if !@email.nil?
      flash[:notice] = "Emails are being collected.  Please be patient."
      redirect_to loading_path
    else
      flash[:alert] = "Emails failed"
      redirect_to projects_path
    end
  end

  def show
    @email = Email.find params[:id]
    respond_to do |format|
      format.html
      format.json  { render json: @email.to_json }
    end
  end

  def search
    @my_emails = Email.search_email(params[:q])
    @my_emails = @my_emails.where project_id: session[:project]
  end

  def search_date
    @my_emails = Email.search_email_date(params[:q])
    @my_emails = @my_emails.where project_id: session[:project]
  end

  def loading
    @that = Delayed::Job.last
    @count = Email.where project_id: session[:project]
    @this = @count.length
    if @this == 1000
      flash[:notice] = "Emails have been collected."
      redirect_to root_path
    end

  end

end