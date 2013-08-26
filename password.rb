# encoding: utf-8

file = File.read("words.txt")
puts "Ditt nya lösenord:"
p file.lines.to_a.sample(4).map(&:strip).join(" ")
