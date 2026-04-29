#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

nvoip_require_var NVOIP_CALLER
ACCESS_TOKEN="${NVOIP_ACCESS_TOKEN:-$(nvoip_create_access_token)}"
TARGET_NUMBER="${NVOIP_TARGET_NUMBER:-11999999999}"
AUDIO_MESSAGE="${NVOIP_AUDIO_MESSAGE:-Sua mensagem de voz aqui}"

nvoip_send_voice_torpedo "$ACCESS_TOKEN" "$NVOIP_CALLER" "$TARGET_NUMBER" "$AUDIO_MESSAGE"
