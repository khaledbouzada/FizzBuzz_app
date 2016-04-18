class UsersController < ApplicationController
  def index
    show_debug
    @user = User.find(params[:id]) unless params[:id].nil?
    @user = User.first if params[:id].nil?

    @numbers = @user.numbers.pluck(:value)
    increment = 0
    @page = params[:page].nil? || params[:page] == "1" ? 1 : params[:page]
    @per_page = params[:per_page].nil? ? 100 : params[:per_page].to_i
    @page_links = @page == "1" ? false : true
    # increment = increment + 1000000 if @page.to_i % 1999 == 0
    x = 1 + increment; y = 100000 + increment

    @array = (x.to_s..y.to_s).to_a.paginate(:page => @page, :per_page => @per_page)

    if request.post?
      respond_to do |format|
        format.js { render :rover }
      end
    else
      respond_to do |format|
        format.html
        format.json { render :json => @user.to_json(:include => [:numbers]), status: :ok }
      end
    end
  end

  def show
    render json: User.find(params[:id]).to_json(:include => [:numbers]), status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user.to_json, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    show_debug
    user = User.find(params[:id])
    user.numbers.create(value: params[:number])
    respond_to do |format|
      format.html { render :nothing => true, :status => 200 }
      format.json { render :json => 'ok' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name)
  end

  def show_debug
    puts "*************************************************---------------------------------*************************************************"
    puts "params are : #{params}"
    puts "request url is  : #{request.url}"
    puts "*************************************************---------------------------------*************************************************"
  end
end
