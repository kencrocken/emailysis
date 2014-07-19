class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
    end
  end

  def about
  end

  def contact
  end

  def send_mail
    name = params[:name]
    email = params[:email]
    body = params[:comments]
    WelcomeMailer.contact_email(name, email, body).deliver
    redirect_to root_path, notice: 'Message sent'
  end
  
end