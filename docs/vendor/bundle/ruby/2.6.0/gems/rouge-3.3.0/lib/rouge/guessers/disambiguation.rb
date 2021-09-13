# frozen_string_literal: true

module Rouge
  module Guessers
    class Disambiguation < Guesser
      include Util
      include Lexers

      def initialize(filename, source)
        @filename = File.basename(filename)
        @source = source
      end

      def filter(lexers)
        return lexers if lexers.size == 1
        return lexers if lexers.size == Lexer.all.size

        @analyzer = TextAnalyzer.new(get_source(@source))

        self.class.disambiguators.each do |disambiguator|
          next unless disambiguator.match?(@filename)

          filtered = disambiguator.decide!(self)
          return filtered if filtered
        end

        return lexers
      end

      def contains?(text)
        return @analyzer.include?(text)
      end

      def matches?(re)
        return !!(@analyzer =~ re)
      end

      @disambiguators = []
      def self.disambiguate(*patterns, &decider)
        @disambiguators << Disambiguator.new(patterns, &decider)
      end

      def self.disambiguators
        @disambiguators
      end

      class Disambiguator
        include Util

        def initialize(patterns, &decider)
          @patterns = patterns
          @decider = decider
        end

        def decide!(guesser)
          out = guesser.instance_eval(&@decider)
          case out
          when Array then out
          when nil then nil
          else [out]
          end
        end

        def match?(filename)
          @patterns.any? { |p| test_glob(p, filename) }
        end
      end

      disambiguate '*.pl' do
        next Perl if contains?('my $')
        next Prolog if contains?(':-')
        next Prolog if matches?(/\A\w+(\(\w+\,\s*\w+\))*\./)
      end

      disambiguate '*.h' do
        next ObjectiveC if matches?(/@(end|implementation|protocol|property)\b/)
        next ObjectiveC if contains?('@"')

        C
      end

      disambiguate '*.m' do
        next ObjectiveC if matches?(/@(end|implementation|protocol|property)\b/)
        next ObjectiveC if contains?('@"')

        next Mathematica if contains?('(*')
        next Mathematica if contains?(':=')

        next Matlab if matches?(/^\s*?%/)
      end

      disambiguate '*.php' do
        # PHP always takes precedence over Hack
        PHP
      end

      disambiguate '*.hh' do
        next Cpp if matches?(/^\s*#include/)
        next Hack if matches?(/^<\?hh/)
        next Hack if matches?(/(\(|, ?)\$\$/)

        Cpp
      end
    end
  end
end
