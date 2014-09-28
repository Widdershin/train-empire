module GamesHelper
  def train_card_action_type(card)
    card.color == :wild ? 'draw_wild_card' : 'draw_train_card'
  end

  def link_svg(link)
    LinkPresenter.new(link).svg
  end

  class LinkPresenter
    attr_reader :link

    def initialize(link)
      @link = link
    end

    def svg
      <<-SVG.strip_heredoc.html_safe
        <path class="link" data-id="#{id}"
              d="#{path}" stroke="#{line_color}" fill="transparent"
              stroke-dasharray="#{dasharray}" stroke-width="#{line_width}"/>
      SVG
    end

    def dasharray
      owner.nil? ? super : nil
    end

    def line_color
      owner.nil? ? color : "##{owner.color}"
    end

    def line_width
      owner.nil? ? 6 : 10
    end

    def path
      <<-PATH.strip_heredoc
        M#{city_a.x} #{city_a.y}
        Q #{curve_x} #{curve_y},
          #{city_b.x} #{city_b.y}
      PATH
    end

    def method_missing(meth, *args)
      if link.respond_to? meth
        link.send(meth)
      else
        super
      end
    end

  end
end
