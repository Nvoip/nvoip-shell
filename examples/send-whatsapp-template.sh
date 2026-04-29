#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

nvoip_require_var NVOIP_WA_TEMPLATE_ID
nvoip_require_var NVOIP_WA_DESTINATION
nvoip_require_var NVOIP_WA_INSTANCE
nvoip_require_var NVOIP_WA_LANGUAGE

ACCESS_TOKEN="${NVOIP_ACCESS_TOKEN:-$(nvoip_create_access_token)}"
BODY_VARIABLES="${NVOIP_WA_BODY_VARIABLES:-[]}"
HEADER_VARIABLES="${NVOIP_WA_HEADER_VARIABLES:-[]}"
TO_FLOW="${NVOIP_WA_TO_FLOW:-false}"

nvoip_send_whatsapp_template \
  "$ACCESS_TOKEN" \
  "$NVOIP_WA_TEMPLATE_ID" \
  "$NVOIP_WA_DESTINATION" \
  "$NVOIP_WA_INSTANCE" \
  "$NVOIP_WA_LANGUAGE" \
  "$BODY_VARIABLES" \
  "$HEADER_VARIABLES" \
  "$TO_FLOW"
