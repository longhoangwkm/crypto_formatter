# CryptoFormatter

A Ruby gem that provides convenient number formatting methods for both cryptocurrency and fiat currency values. Easily format numbers as Bitcoin satoshis, tokens, or various fiat currencies with proper symbols and formatting.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crypto_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crypto_formatter

## Usage

### Cryptocurrency Formatting

```ruby
# Convert to Bitcoin satoshis
1.to_satoshi          # => 100000000
0.5.to_satoshi        # => 50000000

# Convert satoshis to token format
100000000.to_token    # => "1.0"
50000000.to_token     # => "0.5"

# Custom token format (decimal places)
1000.to_token(format: 3)  # => "1.0"
500.to_token(format: 3)   # => "0.5"
```

### Fiat Currency Formatting

```ruby
# Basic USD formatting (default)
1234.56.to_currency   # => "$1,234.56"
1000000.to_currency   # => "$1,000,000.00"

# Different currencies
1234.56.to_currency(currency: 'EUR')  # => "€1,234.56"
1234.56.to_currency(currency: 'GBP')  # => "£1,234.56"
1234.56.to_currency(currency: 'JPY', precision: 0)  # => "¥1,235"

# Specific currency methods
1234.56.to_usd        # => "$1,234.56"
1234.56.to_eur        # => "€1,234.56"
1234.56.to_gbp        # => "£1,234.56"
1234.56.to_jpy        # => "¥1,235" (no decimals by default)
1234.56.to_cad        # => "C$1,234.56"
1234.56.to_aud        # => "A$1,234.56"
1234.56.to_chf        # => "CHF 1,234.56"

# Custom precision
1234.567.to_currency(precision: 3)  # => "$1,234.567"
1234.567.to_currency(precision: 1)  # => "$1,234.6"
1234.567.to_currency(precision: 0)  # => "$1,235"

# Custom delimiters and separators
1234.56.to_currency(delimiter: '.', separator: ',')  # => "$1.234,56"
1234567.89.to_currency(delimiter: ' ')               # => "$1 234 567.89"

# Works with both integers and floats
1234.to_currency      # => "$1,234.00"
1234.56.to_currency   # => "$1,234.56"
```

### Supported Currencies

The gem supports the following currencies with proper symbols:

- **USD** ($) - US Dollar
- **EUR** (€) - Euro
- **GBP** (£) - British Pound
- **JPY** (¥) - Japanese Yen
- **CAD** (C$) - Canadian Dollar
- **AUD** (A$) - Australian Dollar
- **CHF** (CHF) - Swiss Franc
- **SEK** (kr) - Swedish Krona
- **NOK** (kr) - Norwegian Krone
- **DKK** (kr) - Danish Krone
- **HKD** (HK$) - Hong Kong Dollar
- **SGD** (S$) - Singapore Dollar
- **NZD** (NZ$) - New Zealand Dollar

For unsupported currencies, the currency code will be appended after the formatted number.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/crypto_formatter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CryptoFormatter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/crypto_formatter/blob/master/CODE_OF_CONDUCT.md).
