class PoeFilterGenerator::Element
  ATTRS = %i[
    base_type
    corrupted
    drop_level
    elder_item
    gem_level
    has_explicit_mod
    height
    identified
    item_level
    klass
    linked_sockets
    map_tier
    prophecy
    quality
    rarity
    shaped_map
    shaper_item
    socket_group
    sockets
    stack_size
    width

    custom_alert_sound
    disable_drop_sound
    minimap_icon
    play_alert_sound
    play_alert_sound_positional
    play_effect
    set_background_color
    set_background_color_alpha
    set_border_color
    set_border_color_alpha
    set_color_alpha
    set_font_size
    set_text_color
    set_text_color_alpha
  ].freeze

  attr_accessor :name
  attr_accessor :showable
  ATTRS.each do |attr|
    attr_accessor attr
  end

  def initialize name, aliases
    @name = name
    @aliases = aliases
    @showable = true
  end

  def generate file
    file.puts "# #{@name}" if @name.present?
    file.puts showable ? 'Show' : 'Hide'
    put_attr(file)
  end

  def merge other
    return self if other.nil?
    new_element = PoeFilterGenerator::Element.new("#{name}, #{other.name}", @aliases)
    new_element.showable = other.showable
    ATTRS.each do |attr|
      new_element.send("#{attr}=", other.send(attr) || send(attr))
    end
    new_element
  end

private

  def get_key attr
    attr == :klass ? 'Class' : attr.to_s.camelize
  end

  def get_value attr, key
    v = send(attr)
    v = v.join(' ') if v.is_a? Array

    if key&.match?(/Color/)
      if v&.match?(/[0-9]{1,3} [0-9]{1,3} [0-9]{1,3} [0-9]{1,3}/)
        STDERR.puts "[Error] '#{v}' is setted alpha. Use '#{key.underscore}_alpha' instead."
      else
        merge_color_value attr, v
      end
    else
      send(attr)
    end
  end

  def merge_color_value attr, value
    if send("#{attr}_alpha").present?
      "#{value} #{send("#{attr}_alpha")}"
    elsif send("set_color_alpha").present?
      "#{value} #{send('set_color_alpha')}"
    else
      value
    end
  end

  def put_attr file
    ATTRS.each do |attr|
      key = get_key attr

      next if key&.match?(/ColorAlpha/)
      next unless send(attr).present?

      value = get_value attr, key

      @aliases.each do |alias_key, alias_value|
        value.gsub!(alias_key, alias_value) if value.respond_to?(:gsub!)
      end

      file.puts "    #{key} #{value}"
    end
  end
end
