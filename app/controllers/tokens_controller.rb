class TokensController < ApplicationController
  def index
    @tokens = Current.user.tokens
  end

  def new
    @token = Token.new
  end

  def create
    @token = Token.create(token_params.with_defaults(user: Current.user))
    if @token.save
      redirect_to ({ action: :index }), notice: "Token successfully created"
    else
      render :new, status: :unprocessable_entity, alert: "Token could not be created"
    end
  end

  def destroy
    @token = Token.find(params[:id])
    if @token.destroy
      redirect_to ({ action: :index }), notice: "Token successfully deleted"
    else
      redirect_to ({ action: :index }), alert: "Something went wrong"
    end
  end

  @private

  def token_params
    params.require(:token).permit(:name)
  end
end
