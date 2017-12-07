class PoeFilterGenerator::Element
  ATTRS = %i(
    item_level
    drop_level
    quality
    rarity
    klass
    base_type
    sockets
    linked_sockets
    socket_group
    height
    width
    identified
    corrupted
    elder_item
    shaper_item
    shaped_map

    set_border_color
    set_background_color
    set_text_color
    set_font_size
    play_alert_sound
    play_alert_sound_positional
  ).freeze

  attr_accessor :name
  attr_accessor :showable
  ATTRS.each do |attr|
    attr_accessor attr
  end

  def initialize(name, aliases)
    @name = name
    @aliases = aliases
    @showable = true
  end

  def generate(file)
    file.puts "# #{@name}" if @name.present?
    file.puts showable ? 'Show' : 'Hide'
    put_attr(file)
  end

  def merge(other)
    return self if other.nil?
    new_element = PoeFilterGenerator::Element.new("#{name} #{other.name}", @aliases)
    new_element.showable = other.showable
    ATTRS.each do |attr|
      new_element.send("#{attr}=", other.send(attr) || send(attr))
    end
    new_element
  end

private

  def put_attr(file)
    ATTRS.each do |attr|
      key   = attr == :klass ? 'Class' : attr.to_s.camelize
      value = send(attr)

      next unless value.present?

      @aliases.each do |alias_key, alias_value|
        value.gsub!(alias_key, alias_value) if value.respond_to?(:gsub!)
      end

      file.puts "    #{key} #{value}"
    end
  end
end
