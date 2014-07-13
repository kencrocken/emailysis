class EmailsController < ApplicationController

  def new
    @email = Email.delay.email_fetch(session[:project], current_user.email, session[:token])

    if !@email.nil?
      flash[:notice] = "Emails are being collected.  Please be patient."
      redirect_to project_path(session[:project])
    else
      flash[:alert] = "Emails failed"
      redirect_to projects_path
    end
  end

  def show
    @email = Email.find params[:id]
  end

  def search
    @my_emails = Email.search_email(params[:q])
    @my_emails = @my_emails.where project_id: session[:project]
  end

end