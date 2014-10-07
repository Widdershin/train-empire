class CityPresenter
  attr_reader :city
  def initialize(city)
    @city = city
  end

  def method_missing(meth, *args)
    if city.respond_to? meth
      city.send(meth, *args)
    else
      super
    end
  end

  def svg
    <<-SVG.strip_heredoc.html_safe
      <g>
        <circle cx="#{x}" cy="#{y}" r="#{radius}" fill="lightgray"/>

        <text class="city-label"
            x="#{x}" y="#{y - (radius)}"
            width="20"
            text-anchor="middle"
            data-id="#{city.id}"
            >
          #{name}
        </text>
      </g>
    SVG
  end

  private

  def radius
    10
  end
end
