# encoding: utf-8

require "rubygems"
require "bundler"
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

get "/" do
  %{
    <head>
      <title>Svenskt XKCD-lösenord</title>
      <style>
        body {
          text-align: center;
          padding: 20px;
          font-family: "Helvetica Neue", Helvetica, sans-serif;
        }

        p, button {
          font-size: 16px;
        }

        button {
          padding: 8px;
        }

        .suggestion {
          font-family: monospace;
          font-size: 30px;
        }

        footer {
          margin-top: 50px;
          font-size: 10px;
        }
      </style>
    </head>
    <body>
      <h1>Ditt nya lösenord:</h1>
      <p class="suggestion">#{words(4).join(" ")}</p>
      <form>
        <button>Ge mig ett till!</button>
      </form>
      <p>(Eller ladda om sidan.)</p>

      <footer>
        <p>Svenskt XKCD-lösenord (lösenfras) / Swedish XKCD password (passphrase).</p>
        <p>Av <a href="http://henrik.nyh.se">Henrik Nyh</a>.</p>
        <p>Inspirerat av <a href="http://xkcd.com/936/">XKCD 936</a> och <a href="http://preshing.com/20110811/xkcd-password-generator">en engelsk generator</a>.</p>
        <p>#{format count} vanliga ord ^ 4 positioner = #{format count**4} möjligheter.</p>
      </footer>
    </body>
  }
end

helpers do
  def format(number)
    number.to_s.reverse.gsub(/.{3}/, '\0 ').reverse
  end

  def words(count = 4)
    lines.sample(count).map(&:strip)
  end

  def count
    lines.length
  end

  def lines
    file = File.read("words.txt")
    @lines ||= file.lines.to_a
  end
end
