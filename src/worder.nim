# Worder: It gets the words!

import strutils
import random

var words: seq[string]

proc init*(file = "assets/dictionary.txt") =
  randomize()
  words = splitlines(readFile(file));

proc get_random_word*(min_size = 0, max_size = int.high): string =
  let word = words[rand(0..<words.len())]
  if word.len() > min_size and word.len() < max_size: return word
  return get_random_word(min_size, max_size)