# It's hangman!

const num_stages = 7

proc get_word(): string =
  echo "Enter a word:"
  return readLine(stdin)

proc get_letter(): char =
  echo "Enter a letter:"
  let input = readLine(stdin)
  if input.len() < 1: return get_letter()
  return input[0]

proc run(word: string, solved: var seq[bool]): bool =
  var guess = get_letter()
  var is_correct = false;
  for i in 0..<word.len():
      if word[i] == guess:
          solved[i] = true;
          is_correct = true;
  return is_correct

proc get_is_done(solved: seq[bool]): bool =
  var is_done = true;
  for s in solved:
      if not s: is_done = false
  return is_done

proc disp(word: string, solved: seq[bool]) =
  for i in 0..<word.len():
      if solved[i]:
          stdout.write " ", word[i]
      else:
          stdout.write " _"
  echo ""

proc show_stage(stage: int) =
  let art_file = open("assets/ascii.txt")
  const size = 23

  var line: TaintedString
  var i = 0;
  while readLine(art_file, line):
    if i div size == stage mod num_stages:
      echo line
    inc(i)
  
var word = get_word()
var solved = newSeq[bool](word.len())
var stage = 0;
show_stage(stage)
while true:
  disp(word, solved)
  if get_is_done(solved):
      echo "You got it!"
      break
  if run(word, solved):
      echo "You got letter(s)!"
  else:
      echo "oh no, no letter(s)"
      inc(stage)
      show_stage(stage)
      if stage + 1 >= num_stages: break