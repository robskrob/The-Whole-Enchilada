class Lines
  attr_accessor :long, :standard

  def initialize(lines)
    @long = lines[:long]
    @standard = lines[:standard]
  end

end
