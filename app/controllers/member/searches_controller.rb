# frozen_string_literal: true

class Member::SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    case @model
    when "company"
      @records = Company.search_for(@content, @method).page(params[:page]).per(10)
    when "member"
      @records = Member.search_for(@content, @method).page(params[:page]).per(10)
    end
  end
end
