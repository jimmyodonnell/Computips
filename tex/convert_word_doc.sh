#!/usr/bin/env bash

# Dependencies:
# textutil: pre-installed on Mac by default (probably with xcode/command line utilities)
# pandoc: install using homebrew (brew install pandoc)

# Convert document from word (.docx) to latex (.tex)
textutil -convert html "mydoc.docx" -stdout | pandoc -s -f html -t latex -o "mydoc.tex"

# Convert document from latex (.tex) to word (.docx)
pandoc -t docx -f latex -o "backtoword.docx" "mydoc.tex"
