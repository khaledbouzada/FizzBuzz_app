class UsersController < ApplicationController
  def index
    @user = User.find(params[:id]) unless params[:id].nil?
    @user = User.first if params[:id].nil?

    @numbers = @user.numbers.pluck(:value)
    @per_page = params[:page].nil? || params[:page] == "1" ? 100 : 1000
    x = 1; y=50000
    @array = (x.to_s..y.to_s).to_a.paginate(:page => params[:page], :per_page => 100)


    respond_to do |format|
      format.html
      format.json { render :json => @user.to_json(:include => [:numbers]), status: :ok }
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
      # format.json { render json: user.numbers, status: :ok }
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name)
  end
end
