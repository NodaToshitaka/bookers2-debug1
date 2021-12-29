class AlinesController < ApplicationController

  def aline
    selection = params[:aline]
    @books = Book.sort(selection)
  end

end
