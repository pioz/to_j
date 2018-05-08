class AuthorsController < ApplicationController

  def index
    @authors = Author.includes(:books).all
    respond_to do |format|
      #format.json { render json: @authors }
      format.json { render :index }
    end
  end

end
