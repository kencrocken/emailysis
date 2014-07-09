class EmailsController < ApplicationController

  def new
    @email = Email.email_fetch(session[:project], current_user.email, session[:token])

    if !@email.nil?
      flash[:notice] = "Emails populated"
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
  end

end