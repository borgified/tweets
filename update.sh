#!/bin/sh
#
# Updates the repo with new tweets.
#
# Assumes that `last-tweet-id` in your root already contains the last tweet ID
# you've made.
set -x

login="captain_fwiffo"
email="borgified@gmail.com"

last_id=$(cat last-tweet-id)

/home/fwiffo/scripts/madrox/bin/madrox --import=twitter --since-id=$last_id --email=$email $login
git merge -s ours $login 

last_id=$(curl https://twitter.com/users/show/$login.json --silent |
          tr ',' "\n" |
          grep -m2 '"id_str"' |
          sed -e 's/"id_str"://g' |
          sed -e 's/\"//g' |
          tail -n1)
echo $last_id > last-tweet-id
