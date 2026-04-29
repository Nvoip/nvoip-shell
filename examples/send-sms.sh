#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

ACCESS_TOKEN="${NVOIP_ACCESS_TOKEN:-$(nvoip_create_access_token)}"
TARGET_NUMBER="${NVOIP_TARGET_NUMBER:-11999999999}"
MESSAGE="${NVOIP_SMS_MESSAGE:-Mensagem de teste Nvoip}"

nvoip_send_sms "$ACCESS_TOKEN" "$TARGET_NUMBER" "$MESSAGE" false
