#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

ACCESS_TOKEN="${NVOIP_ACCESS_TOKEN:-$(nvoip_create_access_token)}"
nvoip_list_whatsapp_templates "$ACCESS_TOKEN"
