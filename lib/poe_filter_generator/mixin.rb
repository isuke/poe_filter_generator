class PoeFilterGenerator::Mixin
  attr_accessor :elements

  def initialize aliases
    @aliases = aliases
    @elements = []
  end

  def element name = nil
    element = PoeFilterGenerator::Element.new(name, @aliases)
    yield element
    @elements << element
  end
end
