class TokensController < ApplicationController
  def index
    @tokens = Current.user.tokens
  end

  def new
    @token = Token.new
  end
end
