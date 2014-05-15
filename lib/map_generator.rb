class MapGenerator

  def initialize(options)
    @streets = options[:streets]
  end

  def generate
    line_1_parts = []
    line_2_parts = []
    line_3_parts = []

    @streets.each do |street|
      street_length = street.length
      line_1_parts << street
      line_2_parts << "|".center(street_length, " ")
      line_3_parts << ("-" * street.length)
    end

    [
      " " + line_1_parts.join(" " * 12) + " ",
      " " + line_2_parts.join(" " * 12) + " ",
      "-" + line_3_parts.join("-" * 12) + "-",
      " " + line_2_parts.join(" " * 12) + " ",
    ].join("\n")
  end

end