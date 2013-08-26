# Builds a dictionary of common words that should be easy to remember.
# We don't need many: http://preshing.com/20110811/xkcd-password-generator
# suggests the original XKCD comic makes do with a 2048 word dictionary.
#
# We use two word lists. One is inflected and not as nice, but is sorted
# by frequency (in a corpus), so we can use it to figure out common words,
# even though we'll pick them from the other, cleaner list.

require "set"
require "open-uri"

def top_n_words(max)
  words = Set.new

  File.open("stats_SUC3.txt").each_line do |line|
    word = line.split("\t", 2).first
    words << word.downcase  # Doesn't handle non-ASCII.
    break if words.length == max
  end

  words
end

common_words = top_n_words(10_000)

words = Set.new

File.read("saldo20v00.txt").each_line do |line|
  next if line[0] == "#"  # Skip comments.
  word = line.split("..", 2).first  # Get only the word.
  word.gsub!("_", " ")  # Encoded spaces.
  word.strip!  # Some had leading encoded spaces.
  next if word.match(/[ \d[:upper:]]/)  # Not so word-like.
  next if word.length > 8  # Too long to remember.

  # Common words are easier to remember.
  next unless common_words.include?(word)

  words << word
end

File.write("../words.txt", (words.to_a.join("\n") + "\n"))

puts "Words:"
puts words.length
