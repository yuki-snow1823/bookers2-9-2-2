class UsersController < ApplicationController
	before_action :authenticate_user! 
	before_action :baria_user, only: [:edit,:update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
		@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）、書いてあった
		
		@users = User.all #仮

    @currentUserEntry = UserRoom.where(user_id: current_user.id)
		@userEntry = UserRoom.where(user_id: @user.id)
		# ルームを作った方（押した方）と、ルームを作られる方（押された方）の情報を格納

		unless @user.id == current_user.id
			# showページがマイページではない場合（前提）
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
					# すでにルームがある場合とない場合のif
					if cu.room_id == u.room_id then
						# すでに作成されているルームを特定、どっちがどっちに入ろうと同じということ？
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = UserRoom.new
      end
		end
		
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）？
	end
	
	def edit
		@user = User.find(params[:id])
	end

  def update
		@user = User.find(params[:id])
		
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render action: :edit
  	end
	end
	
	# ==============追加================
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
# ==============追加================

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
	
end
