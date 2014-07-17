class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]


  def index
    @projects = current_user.projects.all
  end



  def show

    session[:project] = @project.id
    if !@project.emails.empty?

        @inbox = @project.emails.order(sent_at: :desc).where folder: "inbox"
        @sent = @project.emails.order(sent_at: :desc).where folder: "sent"

        @inbox_date_array = []
        @sent_date_array = []
        @sender_array = []
        @to_array = []
        
        ## --- Inbox range and start date
        @start_date = @inbox.first
        @end_date = @inbox.last
        @start = @start_date.sent_at
        @end = @end_date.sent_at
        @inbox_date_difference = (@start.to_date - @end.to_date).to_i
        @start_year = @end.to_time.strftime('%Y')
        @start_month = @end.to_time.strftime('%m')
        @start_month = @start_month.to_i
        @start_month -= 1
        @start_day = @end.to_time.strftime('%d')

        ## --- Sent range and start date
        @sent_start= @sent.first
        @sent_end= @sent.last
        @sent_start_date = @sent_start.sent_at.to_date
        @sent_end_date = @sent_end.sent_at.to_date
        @sent_date_difference = (((@sent_end_date - @sent_start_date)%12)+2).to_i
        @sent_start_year = @sent_start_date.to_time.strftime('%Y')
        @sent_start_month = @sent_start_date.to_time.strftime('%m')
        @sent_start_month = @sent_start_month.to_i
        @sent_start_month -= 1
        @sent_start_day = @sent_start_date.to_time.strftime('%d')

      @inbox.each do |info|

        x = info.sent_at.to_datetime
        x = x.to_time.to_i
        @inbox_date_array << x

        y = info.from
        @sender_array << y

      end

      @sent.each do |info|

        x = info.sent_at.to_datetime
        x = x.to_time.to_i
        @sent_date_array << x

        y = info.to
        @to_array << y
      end

      @inbox_date_count = Email.email_count(@inbox_date_array)
      @sent_date_count = Email.email_count(@sent_date_array)
      @sender_count = Email.sender_count(@sender_array)
      @to_count = Email.sender_count(@to_array)


      @inbox = @inbox.order(:sent_at).reverse_order
      @sent = @sent.order(:sent_at).reverse_order
      @inbox = @inbox.paginate(page: params[:page], :per_page => 20)
      @sent = @sent.paginate(page: params[:page], :per_page => 20)
      
    end 
  end



  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      flash[:notice] = "New project created."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted."
    redirect_to root_path
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def set_project
      @project = current_user.projects.find params[:id]
    end

end
