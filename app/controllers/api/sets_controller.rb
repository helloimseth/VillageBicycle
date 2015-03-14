class Api::SetsController < ApplicationController
  def index
    @sizes = Size.all
    @categories = Category.all
    @neighborhoods = Neighborhood.all
    @extras = Extra.all
  end
end
