# Calcifer

Calcifer helps you find test files that are directly related to the files you changed.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'calcifer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calcifer

## Usage

To search for related files using uncommitted changes, just do the following

    $ bundle exec calcifer | xargs bundle exec rspec

To search for related files using the other branch changes as a reference, just do the following


    $ bundle exec calcifer -b 'branch_name' | xargs bundle exec rspec
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GustavoDuarteM/calcifer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Calcifer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/calcifer/blob/master/CODE_OF_CONDUCT.md).
