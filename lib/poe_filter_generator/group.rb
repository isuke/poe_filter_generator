class PoeFilterGenerator::Group
  def initialize(name, aliases)
    @name = name
    @aliases = aliases
    @elements = []
    @mixins = []
  end

  def generate(file)
    file.puts '#' * 80
    file.puts "# #{@name}"
    file.puts '#' * 80

    mixins_elements = @mixins.map { |m| m.elements << nil }
    @elements.product(*mixins_elements).map(&:compact).each do |producted_elements|
      element = producted_elements.delete_at(0)
      producted_elements.each do |producted_element|
        element = element.merge(producted_element)
      end

      element.generate(file)
    end

    file.puts
  end

  def element(name = nil)
    element = PoeFilterGenerator::Element.new(name, @aliases)
    yield element
    @elements << element
  end

  def mixin
    mixin = PoeFilterGenerator::Mixin.new(@aliases)
    yield mixin
    @mixins << mixin
  end
end
