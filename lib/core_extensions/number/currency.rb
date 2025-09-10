module CoreExtensions
  module Number
    module Currency
      # Crypto currency methods
      def to_satoshi
        (self * 1e8).to_i
      end

      def to_token(format: 8)
        (self.to_i / (10**format).to_f).to_d.to_s('F')
      end

      # Fiat currency formatting methods
      def to_currency(currency: 'USD', precision: 2, delimiter: ',', separator: '.')
        formatted_number = format_number(self, precision: precision, delimiter: delimiter, separator: separator)
        currency_symbol = get_currency_symbol(currency)
        
        case currency.upcase
        when 'USD', 'CAD', 'AUD', 'HKD', 'SGD', 'NZD'
          "#{currency_symbol}#{formatted_number}"
        when 'EUR', 'GBP', 'JPY', 'CHF', 'SEK', 'NOK', 'DKK'
          "#{currency_symbol}#{formatted_number}"
        else
          "#{formatted_number} #{currency.upcase}"
        end
      end

      def to_usd(precision: 2)
        to_currency(currency: 'USD', precision: precision)
      end

      def to_eur(precision: 2)
        to_currency(currency: 'EUR', precision: precision)
      end

      def to_gbp(precision: 2)
        to_currency(currency: 'GBP', precision: precision)
      end

      def to_jpy(precision: 0)
        to_currency(currency: 'JPY', precision: precision)
      end

      def to_cad(precision: 2)
        to_currency(currency: 'CAD', precision: precision)
      end

      def to_aud(precision: 2)
        to_currency(currency: 'AUD', precision: precision)
      end

      def to_chf(precision: 2)
        to_currency(currency: 'CHF', precision: precision)
      end

      private

      def format_number(number, precision: 2, delimiter: ',', separator: '.')
        # Convert to float and round to specified precision
        rounded = number.to_f.round(precision)
        
        # Split into integer and decimal parts
        integer_part, decimal_part = rounded.to_s.split('.')
        
        # Add thousand separators to integer part
        integer_part = integer_part.reverse.gsub(/(\d{3})(?=\d)/, "\\1#{delimiter}").reverse
        
        # Format final number
        if precision > 0
          decimal_part ||= '0'
          decimal_part = decimal_part.ljust(precision, '0')[0, precision]
          "#{integer_part}#{separator}#{decimal_part}"
        else
          integer_part
        end
      end

      def get_currency_symbol(currency)
        symbols = {
          'USD' => '$',
          'EUR' => '€',
          'GBP' => '£',
          'JPY' => '¥',
          'CAD' => 'C$',
          'AUD' => 'A$',
          'CHF' => 'CHF ',
          'SEK' => 'kr',
          'NOK' => 'kr',
          'DKK' => 'kr',
          'HKD' => 'HK$',
          'SGD' => 'S$',
          'NZD' => 'NZ$'
        }
        symbols[currency.upcase] || currency.upcase
      end
    end
  end
end

if RUBY_VERSION.to_f < 2.4
  Fixnum.include CoreExtensions::Number::Currency
  Float.include CoreExtensions::Number::Currency
else
  Integer.include CoreExtensions::Number::Currency
  Float.include CoreExtensions::Number::Currency
end

