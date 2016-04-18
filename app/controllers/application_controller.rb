class ApplicationController < ActionController::Base
  before_action :create_session
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #disabled to test calls from java
  #protect_from_forgery with: :exception

  private

  def create_session
    if session[:current_user_id].nil?
      @user = User.first if @user.nil?
      session[:current_user_id] = @user.id
      unless Rails.env.test?
        Rails.cache.clear
        Rails.cache.fetch 'huge-array' do
          huge_array = ('1'..'1000000').to_a
          huge_array
        end
      end
    end
  end
end
