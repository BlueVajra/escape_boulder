class MapGenerator

  def initialize(options)
    @locations = options[:locations]
    @current_location_id = options[:current_location_id]
  end

  def generate
    line_1_parts = []
    line_2_parts = []
    line_3_parts = []

    @locations.each do |location|
      street = location[:cross_street]
      street_length = street.length
      line_1_parts << street
      line_2_parts << "|".center(street_length, " ")

      marker = @current_location_id == location[:location] ? "X" : "-"
      line_3_parts << marker.center(street_length, "-")
    end

    [
      " " + line_1_parts.join(" " * 12) + " ",
      " " + line_2_parts.join(" " * 12) + " ",
      "-" + line_3_parts.join("-" * 12) + "-",
      " " + line_2_parts.join(" " * 12) + " ",
    ].join("\n")
  end

end