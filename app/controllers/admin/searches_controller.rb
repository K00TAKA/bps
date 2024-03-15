class Admin::SearchesController < ApplicationController

  def search
    @model=params[:model]
    @content=params[:content]
    @method = params[:method]
    if @model == "company"
      @records=Company.search_for(@content,@method)
    end
  end

end
