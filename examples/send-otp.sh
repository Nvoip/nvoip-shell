#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

ACCESS_TOKEN="${NVOIP_ACCESS_TOKEN:-$(nvoip_create_access_token)}"
OTP_SMS="${NVOIP_OTP_SMS:-${NVOIP_TARGET_NUMBER:-}}"
OTP_VOICE="${NVOIP_OTP_VOICE:-}"
OTP_EMAIL="${NVOIP_OTP_EMAIL:-}"

nvoip_send_otp "$ACCESS_TOKEN" "$OTP_SMS" "$OTP_VOICE" "$OTP_EMAIL"
