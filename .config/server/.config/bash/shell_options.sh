# shellcheck disable=SC2148
# Shell options

## autocd
shopt -s autocd

## Prevent overwriting files with >
## Appending with >> works as normal
## To overwrite with intent, run >|
set -o noclobber

## Update window size after every command
shopt -s checkwinsize

## Append to the history file, don't overwrite it
shopt -s histappend

## Save multi-line commands as one command
shopt -s cmdhist

## Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null

## Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

## Enable history expansion with space
## E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

## Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null

## Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
