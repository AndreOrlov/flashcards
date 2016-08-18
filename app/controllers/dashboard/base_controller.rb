class Dashboard::BaseController < ApplicationController
  before_action :require_login
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:id]
      @card = current_user.cards.find(params[:id])
    elsif current_user.current_block
      @card = current_user.current_block.cards.pending.first
      @card ||= current_user.current_block.cards.repeating.first
    else
      @card = current_user.cards.pending.first
      @card ||= current_user.cards.repeating.first
    end

    respond_to do |format|
      format.html
    end
  end

  private

  def not_authenticated
    redirect_to login_path, alert: t(:please_log_in)
  end

  def not_found
    flash[:alert] = 'Вы обратились к несуществующей записи.'
    redirect_to root_path
  end
end
