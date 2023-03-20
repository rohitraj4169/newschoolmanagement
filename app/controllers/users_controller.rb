class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user
  before_action :require_teacher, only: [ :new, :students] 
  before_action :require_administrative, only: [:index,  :teachers, :destroy]
  


  # GET /users or /users.json
 
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end



  

  # GET /users/1 or /users/1.json
  def show
    if current_user.role.name != "principal" && @user.role.name == "principal"
      redirect_to root_path, alert: "You are not authorized to show this user."
   
    elsif current_user.role.name == "teacher" && @user.role.name == "student" && (@user.teacher.blank? || current_user.id != @user.teacher.id)
      redirect_to root_path, alert: "You are not authorized to show this user."
  
    elsif current_user.role.name == "teacher" && @user.role.name == "teacher" && current_user.id !=@user.id
      redirect_to root_path, alert: "You are not authorized to show this user."
    elsif current_user.role.name == "student" && @user.role.name == "teacher"
      redirect_to root_path, alert: "You are not authorized to show this user."
    elsif current_user.role.name == "student" && @user.role.name == "student" && current_user.id !=@user.id
      redirect_to root_path, alert: "You are not authorized to show this user."
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  
  

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.teacher_id=current_user.id if current_user.role.name=='teacher'
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
 def edit
    if current_user.role.name != "principal" && @user.role.name == "principal"
      redirect_to root_path, alert: "You are not authorized to edit this user."
    elsif current_user.role.name == "student" && @user.role.name == "teacher"
      redirect_to root_path, alert: "You are not authorized to edit this user."
    elsif current_user.role.name == "teacher" && @user.role.name == "teacher" && current_user.id !=@user.id
      redirect_to root_path, alert: "You are not authorized to edit this user."
    elsif current_user.role.name == "student" && @user.role.name == "student" && current_user.id !=@user.id
      redirect_to root_path, alert: "You are not authorized to edit this user."
    end
  end

  def update
    if current_user.role.name != "principal" && @user.role.name == "principal"
      redirect_to @user, alert: "You are not authorized to update this user."
    elsif current_user.role.name == "student" && @user.role.name == "teacher"
      redirect_to @user, alert: "You are not authorized to update this user."
    elsif current_user.role.name == "teacher" && @user.role.name == "teacher" && current_user.id !=@user.id
      redirect_to @user, alert: "You are not authorized to update this user."
    elsif current_user.role.name == "student" && @user.role.name == "student" && current_user.id !=@user.id
      redirect_to @user, alert: "You are not authorized to update this user."
    elsif @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  def teachers
    @teachers = User.where(role_id: 2)
  end
  def students
    @students = User.where(role_id: 3)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :role_id, :name, :fname, :mname, :dob, :phn, :address, :teacher_id)
    end

    def require_same_user
      if current_user != @user && current_user.role.name!='principal'
        flash[:alert] = "You can only edit or delete your own Account"
        redirect_to root_path
      end
    end
   

end
