class PagesController < ApplicationController
  skip_before_action :authorize_request

  def home
  end
end
