class LinkPresenter
  UNOWNED_WIDTH = 8
  OWNED_WIDTH = 12

  attr_reader :link

  def initialize(link)
    @link = link
  end

  def svg
    <<-SVG.strip_heredoc.html_safe
      <path class="link #{line_color}" data-id="#{id}"
            d="#{path}" fill="transparent"
            stroke-dasharray="#{dasharray}" stroke-width="#{line_width}"/>
    SVG
  end

  private

  def method_missing(meth, *args)
    if link.respond_to? meth
      link.send(meth)
    else
      super
    end
  end

  def path
    <<-PATH.strip_heredoc
        M#{city_a.x} #{city_a.y}
        Q #{curve_x} #{curve_y},
          #{city_b.x} #{city_b.y}
    PATH
  end

  def dasharray
    super if owner.nil?
  end

  def line_color
    owner.nil? ? color : "##{owner.color}"
  end

  def line_width
    owner.nil? ? UNOWNED_WIDTH : OWNED_WIDTH
  end

  def center_x
    city_a.x + (city_b.x - city_a.x) / 2
  end

  def center_y
    city_a.y + (city_b.y - city_a.y) / 2
  end

  def curve_x
    center_x + curve_offset_x
  end

  def curve_y
    center_y + curve_offset_y
  end

  def distance_coord
    [(city_b.x - city_a.x), (city_b.y - city_a.y)]
  end

  def line_length
    w, h = distance_coord

    Math.sqrt((w ** 2) + (h ** 2))
  end

  def dasharray
    segment_length = (line_length / cost) * 0.9
    "#{segment_length}, 7"
  end
end
