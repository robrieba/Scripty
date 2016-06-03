# Scripty

## An extensible CLI voice acting management tool for AGS.

Managing thousands of lines of speech in an adventure game can be frazzling.  Scripty can help.

### Commands

#### Dump
```
Usage:
  scripty.rb dump <source_path>

Options:
  [--quiet], [--no-quiet]  

Description:
  Print a complete lising of every line of speech.

  $ ruby scripty dump ../my_ags_game

  Output: <character name>, <line number>, <speech text>

  Ex: CharacterName, 2, &2 Hello!

```

#### Script
```
Usage:
  scripty.rb script <source_path>

Options:
  [--quiet], [--no-quiet]  

Description:
  Print a formatted script of the speech lines in the source code at <source_path>.
  The script will be sorted by the character's name.

  $ ruby scripty script ../my_ags_game

  Output: CharacterName: &100 This is a line of text!

```
