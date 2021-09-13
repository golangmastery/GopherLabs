# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class Properties < RegexLexer
      title ".properties"
      desc '.properties config files for Java'
      tag 'properties'

      filenames '*.properties'
      mimetypes 'text/x-java-properties'

      identifier = /[\w.-]+/

      state :basic do
        rule /[!#].*?\n/, Comment
        rule /\s+/, Text
        rule /\\\n/, Str::Escape
      end

      state :root do
        mixin :basic

        rule /(#{identifier})(\s*)([=:])/ do
          groups Name::Property, Text, Punctuation
          push :value
        end
      end

      state :value do
        rule /\n/, Text, :pop!
        mixin :basic
        rule /"/, Str, :dq
        rule /'.*?'/, Str
        mixin :esc_str
        rule /[^\\\n]+/, Str
      end

      state :dq do
        rule /"/, Str, :pop!
        mixin :esc_str
        rule /[^\\"]+/m, Str
      end

      state :esc_str do
        rule /\\u[0-9]{4}/, Str::Escape
        rule /\\./m, Str::Escape
      end
    end
  end
end
