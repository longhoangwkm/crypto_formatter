RSpec.describe CryptoFormatter do
  it "has a version number" do
    expect(CryptoFormatter::VERSION).not_to be nil
  end

  describe "crypto currency formatting" do
    it "converts to satoshi" do
      expect(1.to_satoshi).to eq(100_000_000)
      expect(0.5.to_satoshi).to eq(50_000_000)
    end

    it "converts to token with default format" do
      expect(100_000_000.to_token).to eq("1.0")
      expect(50_000_000.to_token).to eq("0.5")
    end

    it "converts to token with custom format" do
      expect(1000.to_token(format: 3)).to eq("1.0")
      expect(500.to_token(format: 3)).to eq("0.5")
    end
  end

  describe "fiat currency formatting" do
    describe "#to_currency" do
      it "formats USD by default" do
        expect(1234.56.to_currency).to eq("$1,234.56")
        expect(1000000.to_currency).to eq("$1,000,000.00")
      end

      it "formats different currencies" do
        expect(1234.56.to_currency(currency: 'EUR')).to eq("€1,234.56")
        expect(1234.56.to_currency(currency: 'GBP')).to eq("£1,234.56")
        expect(1234.56.to_currency(currency: 'JPY', precision: 0)).to eq("¥1,235")
      end

      it "handles custom precision" do
        expect(1234.567.to_currency(precision: 3)).to eq("$1,234.567")
        expect(1234.567.to_currency(precision: 1)).to eq("$1,234.6")
        expect(1234.567.to_currency(precision: 0)).to eq("$1,235")
      end

      it "handles custom delimiters and separators" do
        expect(1234.56.to_currency(delimiter: '.', separator: ',')).to eq("$1.234,56")
        expect(1234567.89.to_currency(delimiter: ' ')).to eq("$1 234 567.89")
      end

      it "handles unknown currencies" do
        expect(1234.56.to_currency(currency: 'XYZ')).to eq("1,234.56 XYZ")
      end
    end

    describe "specific currency methods" do
      it "formats USD" do
        expect(1234.56.to_usd).to eq("$1,234.56")
        expect(1234.567.to_usd(precision: 3)).to eq("$1,234.567")
      end

      it "formats EUR" do
        expect(1234.56.to_eur).to eq("€1,234.56")
        expect(1234.567.to_eur(precision: 1)).to eq("€1,234.6")
      end

      it "formats GBP" do
        expect(1234.56.to_gbp).to eq("£1,234.56")
      end

      it "formats JPY with no decimals by default" do
        expect(1234.56.to_jpy).to eq("¥1,235")
        expect(1234.56.to_jpy(precision: 2)).to eq("¥1,234.56")
      end

      it "formats CAD" do
        expect(1234.56.to_cad).to eq("C$1,234.56")
      end

      it "formats AUD" do
        expect(1234.56.to_aud).to eq("A$1,234.56")
      end

      it "formats CHF" do
        expect(1234.56.to_chf).to eq("CHF 1,234.56")
      end
    end

    describe "edge cases" do
      it "handles zero values" do
        expect(0.to_currency).to eq("$0.00")
        expect(0.to_usd).to eq("$0.00")
      end

      it "handles negative values" do
        expect(-1234.56.to_currency).to eq("$-1,234.56")
        expect(-1234.56.to_eur).to eq("€-1,234.56")
      end

      it "handles very large numbers" do
        expect(1234567890.12.to_currency).to eq("$1,234,567,890.12")
      end

      it "handles very small numbers" do
        expect(0.01.to_currency).to eq("$0.01")
        expect(0.001.to_currency(precision: 3)).to eq("$0.001")
      end

      it "works with integers" do
        expect(1234.to_currency).to eq("$1,234.00")
        expect(1234.to_usd).to eq("$1,234.00")
      end

      it "works with floats" do
        expect(1234.56.to_currency).to eq("$1,234.56")
        expect(1234.56.to_eur).to eq("€1,234.56")
      end
    end
  end
end
