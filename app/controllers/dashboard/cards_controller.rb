class Dashboard::CardsController < Dashboard::BaseController
  respond_to :html
  before_action :set_card, only: [:destroy, :edit, :update]

  def index
    @cards = current_user.cards.all.order('review_date')
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create

    @card = current_user.cards.build(card_params)

    # test 4xtrot
    # must save for get id. It uses in name picture filename and store filename in table card.
    check_remote_pics(@card) if @card.save

    if @card.save
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def update
    # test 4xtrot
    check_remote_pics(@card)

    if @card.update(card_params)
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
    # respond_with @card
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :image_remote, :remove_image, :block_id)
  end

  def check_remote_pics(card)
      card.remote_image_url = params[:image_remote] unless params[:image_remote] == ''
  end
end
