# Module game

const num_stages = 7

proc get_word(): string =
  echo "Enter a word:"
  return readLine(stdin)

proc get_letter(): char =
  echo "Enter a letter:"
  let input = readLine(stdin)
  if input.len() < 1: return get_letter()
  return input[0]

proc show_stage(stage: int) =
  let art_file = open("assets/ascii.txt")
  const size = 23

  var line: TaintedString
  var i = 0;
  while readLine(art_file, line):
    if i div size == stage mod num_stages:
      echo line
    inc(i)

type
  game = object
    word: string
    solved: seq[bool]

method disp(this: game) {.base} =
  for i in 0..<this.word.len():
      if this.solved[i]:
          stdout.write " ", this.word[i]
      else:
          stdout.write " _"
  echo ""

method get_is_done(this: game): bool {.base} =
  var is_done = true;
  for s in this.solved:
      if not s: is_done = false
  return is_done

method run(this: var game): bool {.base} =
  var guess = get_letter()
  var is_correct = false;
  for i in 0..<this.word.len():
      if this.word[i] == guess:
          this.solved[i] = true;
          is_correct = true;
  return is_correct

proc start_game*(word = get_word()) =
  var g = game(word: word, solved: newSeq[bool](word.len()))
  var stage = 0;
  show_stage(stage)

  while true:
    g.disp()
    
    if g.get_is_done():
      echo "You got it!"
      break

    if g.run():
      echo "You got letter(s)!"
    else:
      echo "oh no, no letter(s)"
      inc(stage)
      show_stage(stage)
      if stage + 1 >= num_stages: break
