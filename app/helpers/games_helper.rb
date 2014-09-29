module GamesHelper
  def train_card_action_type(card)
    card.color == :wild ? 'draw_wild_card' : 'draw_train_card'
  end

  def link_svg(link)
    LinkPresenter.new(link).svg
  end

  def city_svg(city)
    CityPresenter.new(city).svg
  end

end
