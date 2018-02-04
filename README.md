# Streamlet

[![Build Status](https://travis-ci.org/tjmw/streamlet.svg?branch=master)](https://travis-ci.org/tjmw/streamlet)

Chain operations which may fail or succeed, inspired by forays into functional programming.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'streamlet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install streamlet

## Usage

```ruby
def half_to_whole_number(number)
  halved = number.to_f / 2
  halved % 1 == 0 ? halved.to_i : nil
end

Streamlet.new { half_to_whole_number(16) }.     # => 8
  and_then { |val| half_to_whole_number(val) }. # => 4
  and_then { |val| half_to_whole_number(val) }. # => 2
  and_then { |val| half_to_whole_number(val) }. # => 1
  result # => 1

Streamlet.new { half_to_whole_number(12) }.     # => 6
  and_then { |val| half_to_whole_number(val) }. # => 3
  and_then { |val| half_to_whole_number(val) }. # => nil
  and_then { |val| half_to_whole_number(val) }. # no-op
  result # => nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tjmw/streamlet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Streamlet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tjmw/streamlet/blob/master/CODE_OF_CONDUCT.md).
