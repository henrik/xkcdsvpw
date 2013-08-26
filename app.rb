# encoding: utf-8

require "rubygems"
require "bundler"
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

get "/" do
  %{
    <head>
      <title>Svenskt XKCD-lösenord (lösenfras)</title>
      <style>
        body {
          text-align: center;
          padding: 20px;
        }
        .suggestion {
          font-family: monospace;
          font-size: 25px;
        }
      </style>
    </head>
    <body>
      <h1>Ditt nya lösenord:</h1>
      <p class="suggestion">#{words(4).join(" ")}</p>
    </body>
  }
end

helpers do
  def words(count = 4)
    file = File.read("words.txt")
    file.lines.to_a.sample(count).map(&:strip)
  end
end
