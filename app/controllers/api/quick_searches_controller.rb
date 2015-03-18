class Api::QuickSearchesController < ApplicationController
  def index
    @search_results = PgSearch.multisearch(params[:query])
                              .limit(5)
  end
end
