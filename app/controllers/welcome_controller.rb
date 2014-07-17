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
  
end