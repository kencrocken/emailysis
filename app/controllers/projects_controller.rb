class ProjectsController < ApplicationController


  def index
    @projects = current_user.projects.all
  end



  def show

    @project = current_user.projects.find params[:id]
    if !@project.emails.empty?
      @inbox = @project.emails.order(sent_at: :desc).where folder: "inbox"
      @sent = @project.emails.order(sent_at: :desc).where folder: "sent"

      @inbox_date_array = []
      @sent_date_array = []
      @sender_array = []
      @to_array = []
      @start_date = @project.emails.first
      @end_date = @project.emails.last
      @start = @start_date[:sent_at]
      @end = @end_date[:sent_at]
      @date_difference = (@end.to_date - @start.to_date).to_i
      @start_year = @start_date[:sent_at].to_time.strftime('%Y')
      @start_month = @start_date[:sent_at].to_time.strftime('%m')
      @start_month = @start_month.to_i
      @start_month -= 1
      @start_day = @start_date[:sent_at].to_time.strftime('%d')

      @inbox.each do |info|

        x = info.sent_at
        x = x.to_time.to_i
        x = x.to_s
        @inbox_date_array << x

        y = info.from
        @sender_array << y
      end
    end

    @sent.each do |info|

      x = info.sent_at.to_date
      x = x.to_time.to_i
      @sent_date_array << x

      y = info.to
      @to_array << y

    end

    @inbox_date_count = Email.email_count(@inbox_date_array)
    @sent_date_count = Email.email_count(@sent_date_array)
    @sender_count = Email.sender_count(@sender_array)
    @to_count = Email.sender_count(@to_array)

    project_session
    @inbox = @inbox.order(:sent_at).reverse_order
    @sent = @sent.order(:sent_at).reverse_order
    @inbox = @inbox.paginate(page: params[:page], :per_page => 20)
    @sent = @sent.paginate(page: params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sender_count}
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

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def project_session
      session[:project] = @project.id
    end

end
