class PoeFilterGenerator::Generator
  ROOT_PATH = File.expand_path('../../', __FILE__)

  def initialize(source_path, export_path, aliases_path)
    @source_path = source_path
    @export_path = export_path

    @aliases = {}
    return unless aliases_path
    YAML.load(File.open(aliases_path).read).each do |k, v|
      @aliases[k] = v.flatten.map { |a| %("#{a}") }.join(' ')
    end
  end

  def generate
    # rubocop:disable Lint/Eval
    eval(File.read(@source_path))
    # rubocop:enable Lint/Eval
  end

private

  def filter(name)
    filter = PoeFilterGenerator::Filter.new(name, @export_path, @aliases)
    yield filter
    filter.generate
  end
end
