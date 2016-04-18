class UsersController < ApplicationController

  def index
    @user = User.find_by_id(session[:current_user_id])
    @numbers = @user.numbers.pluck(:value)
    @page = params[:page].nil? || params[:page] == "1" ? 1 : params[:page]
    @per_page = params[:per_page].nil? ? 100 : params[:per_page].to_i
    huge_array = Rails.cache.read 'huge-array'
    @array = huge_array.paginate(:page => @page, :per_page => @per_page)
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

end
