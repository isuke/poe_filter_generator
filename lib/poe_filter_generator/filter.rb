class PoeFilterGenerator::Filter
  attr_accessor :name

  def initialize(name, export_path, aliases)
    @name = name
    @export_path = export_path
    @aliases = aliases
    @groups = []
  end

  def generate
    File.open(File.join(@export_path, "#{@name}.filter"), 'w') do |file|
      file.puts '#' * 80
      file.puts '#'
      file.puts "# generate by poe_filter_generator ver #{PoeFilterGenerator::VERSION}"
      file.puts '#'
      file.puts '#' * 80

      @groups.each do |group|
        group.generate(file)
      end
    end
  end

  def group(name)
    group = PoeFilterGenerator::Group.new(name, @aliases)
    yield group
    @groups << group
  end
end
