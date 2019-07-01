class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :show]

before_action :require_user, except: [:new, :create]

before_action :require_same_user, only: [:edit, :update, :destroy]

before_action :require_same_user2, only: [:show]


before_action :require_admin, only: [:destroy, :index]

def index

@users = User.paginate(page: params[:page], per_page: 5)

end

def new

@user = User.new

end

def create

@user = User.new(user_params)

if @user.save

session[:user_id] = @user.id

flash[:success] = "Thank you for registering #{@user.username}"

redirect_to user_path(@user)

else

render 'new'

end

end

def edit

end

def update

if @user.update(user_params)

flash[:success] = "Account settings were saved"

redirect_to user_path

else

render 'edit'

end

end

def show

@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)

end

def destroy

@user = User.find(params[:id])

@user.destroy

flash[:danger] = "User and all articles created by user have been deleted"

redirect_to users_path

end

private

def user_params

params.require(:user).permit(:username, :email, :password, :password_confirmation, :company, :address, :contact, :Profession)

end

def set_user

@user = User.find(params[:id])

end

def require_same_user

if current_user != @user and !current_user.admin?

flash[:danger] = "You can only edit your own account"

redirect_to root_path

end

end

def require_same_user2

if current_user != @user and !current_user.admin?

flash[:danger] = "You can only access your own account"

redirect_to root_path

end

end



def require_admin

if logged_in? and !current_user.admin?

flash[:danger] = "Only admin users can perform this action"

redirect_to root_path

end

end

end