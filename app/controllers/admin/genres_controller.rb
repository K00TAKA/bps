class Admin::GenresController < ApplicationController

before_action :authenticate_admin!

  def index
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "業種の登録に完了しました"
　　　redirect_to __________
    else
      flash[:notice] = "業種の登録に失敗しました"
      render :__________
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
