require 'yaml'
require 'active_support'
require 'active_support/core_ext'
require 'thor'
require 'poe_filter_generator'

module PoeFilterGenerator
  class CLI < Thor
    default_command :generate

    desc "generate sample.ru /foo/bar/export/ aliases.yml", "generate filter."
    def generate source = './filter.ru',  export = '.', aliases = nil
      PoeFilterGenerator::Generator.new(source, export, aliases).generate
    end
  end
end
