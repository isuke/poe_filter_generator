class PoeFilterGenerator::Filter
  attr_accessor :name

  def initialize name, export_path, aliases
    @name = name
    @comments = []
    @export_path = export_path
    @aliases = aliases
    @groups = []
  end

  def generate
    File.open(File.join(@export_path, "#{@name}.filter"), 'w') do |file|
      file.puts "# generate by poe_filter_generator ver #{PoeFilterGenerator::VERSION}"
      file.puts "# https://github.com/isuke/poe_filter_generator"
      file.puts ''
      if @comments.any?
        file.puts '#' * 80
        file.puts '#'
        @comments.each do |comment|
          file.puts "# #{comment}"
        end
        file.puts '#'
        file.puts '#' * 80
        file.puts ''
      end

      @groups.each do |group|
        group.generate(file)
      end
    end
  end

  def comment str
    @comments << str
  end

  def group name
    group = PoeFilterGenerator::Group.new(name, @aliases)
    yield group
    @groups << group
  end
end
