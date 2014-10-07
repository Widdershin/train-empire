class HandPresenter
  def initialize(hand)
    @hand = hand
  end

  def svg
    <<-SVG.strip_heredoc.html_safe
      <foreignObject width="950" height="100" y="615">
        <div class="hand">
          #{cards}
        </div>
      </foreignObject>
    SVG
  end

  def cards
    @hand.chunk {|card| card.color}.map do |_, cards|
      *most, last = cards

      most.map(&method(:card_html)).join + card_html(last, true)
    end.join
  end

  def card_html(card, last = false)
    <<-HTML
      <div class="card #{card.color} #{"last-card" if last}">
        <input type="checkbox">
      </div>
    HTML
  end

end
