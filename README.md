# Path Of Exile Filter Generator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'poe_filter_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poe_filter_generator

## Usage

Write to filter.ru as follows.

```ruby
filter 'sample' do |f|
  f.group 'Gems' do |g|
    g.element 'Gems' do |e|
      e.showable             = true
      e.klass                = 'Gems'
    end

    g.mixin do |m|
      m.element 'Drop Only' do |e|
        e.base_type            = 'DropOnlyGems'
        e.set_font_size        = 38
        e.set_border_color     = '175  96  37'
      end
    end
    g.mixin do |m|
      m.element 'High Quality' do |e|
        e.quality              = '>= 10'
        e.set_background_color = ' 70   0   0'
      end
      m.element 'Middle Quality' do |e|
        e.quality              = '> 0'
        e.set_background_color = ' 70  70   0'
      end
    end
  end

  f.group 'Default' do |g|
    g.element do |e|
      e.showable = true
    end
  end
end
```

And aliases.yml as follows.

```yml
DropOnlyGems:
  - Vaal
  - Added Chaos Damage
  - Enhance
  - Enlighten
  - Empower
  - Detonate Mines
  - Portal
```

Then, execute command

```sh
poe_filter_generator source="sample.ru" export="." aliases="aliases.yml"
```

export file is sample.filter as follows.

```
################################################################################
# Gems
################################################################################
# Gems Drop Only High Quality
Show
    Quality >= 10
    Class Gems
    BaseType "Vaal" "Added Chaos Damage" "Enhance" "Enlighten" "Empower" "Detonate Mines" "Portal"
    SetBorderColor 175  96  37
    SetBackgroundColor  70   0   0
    SetFontSize 38
# Gems Drop Only Middle Quality
Show
    Quality > 0
    Class Gems
    BaseType "Vaal" "Added Chaos Damage" "Enhance" "Enlighten" "Empower" "Detonate Mines" "Portal"
    SetBorderColor 175  96  37
    SetBackgroundColor  70  70   0
    SetFontSize 38
# Gems Drop Only
Show
    Class Gems
    BaseType "Vaal" "Added Chaos Damage" "Enhance" "Enlighten" "Empower" "Detonate Mines" "Portal"
    SetBorderColor 175  96  37
    SetFontSize 38
# Gems High Quality
Show
    Quality >= 10
    Class Gems
    SetBackgroundColor  70   0   0
# Gems Middle Quality
Show
    Quality > 0
    Class Gems
    SetBackgroundColor  70  70   0
# Gems
Show
    Class Gems

################################################################################
# Default
################################################################################
Show
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/poe_filter_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

