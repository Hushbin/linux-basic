#!/bin/bash

CHAT_ID="some_id" # id of chat to which we need to send a message
TEXT="$1" # text we'll send
BOT_AUTH_TOKEN="your_token" # Telegram-bot token

# -s, --silent        Silent mode
# -S, --show-error    Show error even when -s is used
# -i, --include       Include protocol response headers in the output
#  -m, --max-time <time> Maximum time allowed for the transfer
# send all parameters to "curl", by means of which we'll call API Telegram to send a message.
curl -sS -i --max-time 30 \
        --header 'Content-Type: application/json' \
        --request 'POST' \
        --data '{"chat_id": "'"${CHAT_ID}"'", "text": "'"${TEXT}"'"}' \
        "https://api.telegram.org/bot${BOT_AUTH_TOKEN}/sendMessage" 2>&1
