#!/bin/sh
set -eu
record="$(mktemp)"
trap 'rm -f "$record"' EXIT
curl() { printf '%s\n' "$*" > "$record"; printf '%s' '{"access_token":"token"}'; }
. "$(dirname "$0")/../lib/nvoip.sh"
export NVOIP_OAUTH_CLIENT_ID='id +'
export NVOIP_OAUTH_CLIENT_SECRET='secret:/'
export NVOIP_TOKEN_URL='https://local/auth/oauth2/token'
nvoip_create_access_token >/dev/null
case "$(cat "$record")" in *'grant_type=client_credentials'*'client_id=id +'*) ;; *) exit 1;; esac
nvoip_get_balance token >/dev/null
case "$(cat "$record")" in *'Authorization: Bearer token'*'/balance'*) ;; *) exit 1;; esac
nvoip_check_otp token 'a b&c' 'key/1' >/dev/null
case "$(cat "$record")" in *'Authorization: Bearer token'*'--data-urlencode code=a b&c'*'--data-urlencode key=key/1'*) ;; *) exit 1;; esac
