#!/usr/bin/env bash

# full emoji list: http://unicode.org/emoji/charts/full-emoji-list.html
# good table: http://apps.timwhitlock.info/emoji/tables/unicode

echo -n ❤️  | hexdump
# 0000000 e2 9d a4 ef b8 8f  


echo -e '\t' "\x20\xf0\x9f\x8f\x84" " "  "\xc2\xa1" BANZAI !
echo -e '\tShake, strain, and enjoy!' '\xf0\x9f\x8d\xb9\x0a''\n'

# cocktail 2d 75 20 f0 9f 8d b9 0a        
# surfer 2d 75 20 f0 9f 8f 84 0a         
# darker surfer  2d 75 20 f0 9f 8f 84 f0 9f 8f bd 0a   
