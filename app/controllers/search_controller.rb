class SearchController < ApplicationController
  def search
		@book = Book.new

		# @bookid = Book.find(params[:book_id])
		# 本 とりあえず
		if params[:word].present? && params[:model] === "Book" && params[:search] === "perfect"
			@books = Book.where('title LIKE ?', "#{params[:word]}") 
			# 完全一致

		elsif params[:word].present? && params[:model] === "Book" && params[:search] === "front"
			@books = Book.where('title LIKE ?', "#{params[:word]}%")
			# 前方一致

		elsif params[:word].present? && params[:model] === "Book" && params[:search] === "back"
			@books = Book.where('title LIKE ?', "%#{params[:word]}")
			# 後方一致

		elsif params[:word].present? && params[:model] === "Book" && params[:search] === "part"
			@books = Book.where('title LIKE ?', "%#{params[:word]}%")
			# 部分一致
		else
      # @books = Book.none
		end
		
		# user
		if params[:word].present? && params[:model] === "User" && params[:search] === "perfect"
			@users = User.where('name LIKE ?', "#{params[:word]}")
			# 完全一致

		elsif params[:word].present? && params[:model] === "User" && params[:search] === "front"
			@users = User.where('name LIKE ?', "#{params[:word]}%")
			# 前方一致

		elsif params[:word].present? && params[:model] === "User" && params[:search] === "back"
			@users = User.where('name LIKE ?', "%#{params[:word]}")
			# 後方一致

		elsif params[:word].present? && params[:model] === "User" && params[:search] === "part"
			@users = User.where('name LIKE ?', "%#{params[:word]}%")
			# 部分一致
		else
      # @users = User.none
    end
	end
end
