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
    # name = params[:message][:name]
    # email = params[:message][:email]
    # body = params[:message][:comments]
    puts params[:message]
    if params[:message][:name].empty?
      redirect_to contact_path, alert: "A name is required."
    elsif params[:message][:email].empty?
      redirect_to contact_path, alert: "An email is required."
    else
      WelcomeMailer.contact_email(mail_params).deliver
      redirect_to root_path, notice: 'Message sent'
    end
  end

  private

    def mail_params
      params.require(:message).permit(:name, :email, :comments)
    end
  
end