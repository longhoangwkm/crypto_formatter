module CoreExtensions
  module Number
    module Currency
      def to_token(format: 8)
        (self.to_i / (10**format).to_f).to_d.to_s('F')
      end
    end
  end
end

if RUBY_VERSION.to_f < 2.4
  Fixnum.include CoreExtensions::Number::Currency
  Float.include CoreExtensions::Number::Currency
else
  Integer.include CoreExtensions::Number::Currency
end

