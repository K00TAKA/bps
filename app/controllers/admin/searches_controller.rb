# frozen_string_literal: true

class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "company"
      @records = Company.search_for(@content, @method).page(params[:page]).per(10)
    end
  end
end
