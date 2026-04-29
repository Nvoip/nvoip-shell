#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
. "$SCRIPT_DIR/../lib/nvoip.sh"

nvoip_require_var NVOIP_OTP_CODE
nvoip_require_var NVOIP_OTP_KEY

nvoip_check_otp "$NVOIP_OTP_CODE" "$NVOIP_OTP_KEY"
