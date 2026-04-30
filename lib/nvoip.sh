#!/bin/sh

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"

nvoip_require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Missing required command: %s\n' "$1" >&2
    return 1
  fi
}

nvoip_require_var() {
  var_name="$1"
  eval "var_value=\${$var_name:-}"
  if [ -z "$var_value" ]; then
    printf 'Missing required variable: %s\n' "$var_name" >&2
    return 1
  fi
}

nvoip_json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g' | tr '\n' ' '
}

nvoip_extract_json_string() {
  printf '%s' "$1" | tr -d '\n' | sed -nE "s/.*\"$2\"[[:space:]]*:[[:space:]]*\"([^\"]+)\".*/\1/p"
}

nvoip_encode_basic_auth() {
  client_id="$1"
  client_secret="$2"
  printf '%s' "$client_id:$client_secret" | base64 | tr -d '\n'
}

nvoip_resolve_basic_auth() {
  nvoip_require_var NVOIP_OAUTH_CLIENT_ID || return 1
  nvoip_require_var NVOIP_OAUTH_CLIENT_SECRET || return 1
  nvoip_encode_basic_auth "$NVOIP_OAUTH_CLIENT_ID" "$NVOIP_OAUTH_CLIENT_SECRET"
}

nvoip_create_access_token() {
  nvoip_require_command curl || return 1
  nvoip_require_command base64 || return 1
  nvoip_require_command sed || return 1
  nvoip_require_var NVOIP_NUMBERSIP || return 1
  nvoip_require_var NVOIP_USER_TOKEN || return 1
  basic_auth="$(nvoip_resolve_basic_auth)" || return 1

  response="$(curl -sS \
    --request POST \
    --header "Authorization: Basic $basic_auth" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "username=$NVOIP_NUMBERSIP" \
    --data-urlencode "password=$NVOIP_USER_TOKEN" \
    --data-urlencode "grant_type=password" \
    "$NVOIP_BASE_URL/oauth/token")" || return 1

  token="$(nvoip_extract_json_string "$response" access_token)"
  if [ -z "$token" ]; then
    printf '%s\n' "$response" >&2
    return 1
  fi

  printf '%s\n' "$token"
}

nvoip_refresh_access_token() {
  refresh_token="$1"
  nvoip_require_command curl || return 1
  basic_auth="$(nvoip_resolve_basic_auth)" || return 1

  curl -sS \
    --request POST \
    --header "Authorization: Basic $basic_auth" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=refresh_token" \
    --data-urlencode "refresh_token=$refresh_token" \
    "$NVOIP_BASE_URL/oauth/token"
}

nvoip_send_sms() {
  access_token="$1"
  number_phone="$2"
  message="$3"
  flash_sms="${4:-false}"

  curl -sS \
    --request POST \
    --header "Authorization: Bearer $access_token" \
    --header "Content-Type: application/json" \
    --data-binary "{
      \"numberPhone\": \"$(nvoip_json_escape "$number_phone")\",
      \"message\": \"$(nvoip_json_escape "$message")\",
      \"flashSms\": $flash_sms
    }" \
    "$NVOIP_BASE_URL/sms"
}

nvoip_get_balance() {
  access_token="$1"

  curl -sS \
    --request GET \
    --header "Authorization: Bearer $access_token" \
    "$NVOIP_BASE_URL/balance"
}

nvoip_create_call() {
  access_token="$1"
  caller="$2"
  called="$3"

  curl -sS \
    --request POST \
    --header "Authorization: Bearer $access_token" \
    --header "Content-Type: application/json" \
    --data-binary "{
      \"caller\": \"$(nvoip_json_escape "$caller")\",
      \"called\": \"$(nvoip_json_escape "$called")\"
    }" \
    "$NVOIP_BASE_URL/calls/"
}

nvoip_send_otp() {
  access_token="$1"
  sms="${2:-}"
  voice="${3:-}"
  email="${4:-}"
  payload=''

  if [ -n "$sms" ]; then
    payload="\"sms\": \"$(nvoip_json_escape "$sms")\""
  fi
  if [ -n "$voice" ]; then
    if [ -n "$payload" ]; then
      payload="$payload,"
    fi
    payload="$payload\"voice\": \"$(nvoip_json_escape "$voice")\""
  fi
  if [ -n "$email" ]; then
    if [ -n "$payload" ]; then
      payload="$payload,"
    fi
    payload="$payload\"email\": \"$(nvoip_json_escape "$email")\""
  fi

  if [ -z "$payload" ]; then
    printf 'Missing OTP destination. Send sms, voice or email.\n' >&2
    return 1
  fi

  curl -sS \
    --request POST \
    --header "Authorization: Bearer $access_token" \
    --header "Content-Type: application/json" \
    --data-binary "{$payload}" \
    "$NVOIP_BASE_URL/otp"
}

nvoip_check_otp() {
  code="$1"
  key="$2"

  curl -sS \
    --request GET \
    "$NVOIP_BASE_URL/check/otp?code=$code&key=$key"
}

nvoip_list_whatsapp_templates() {
  access_token="$1"

  curl -sS \
    --request GET \
    --header "Authorization: Bearer $access_token" \
    "$NVOIP_BASE_URL/wa/listTemplates"
}

nvoip_send_whatsapp_template() {
  access_token="$1"
  id_template="$2"
  destination="$3"
  instance="$4"
  language="$5"
  body_variables="${6:-[]}"
  header_variables="${7:-[]}"
  to_flow="${8:-false}"

  curl -sS \
    --request POST \
    --header "Authorization: Bearer $access_token" \
    --header "Content-Type: application/json" \
    --data-binary "{
      \"idTemplate\": \"$(nvoip_json_escape "$id_template")\",
      \"destination\": \"$(nvoip_json_escape "$destination")\",
      \"instance\": \"$(nvoip_json_escape "$instance")\",
      \"language\": \"$(nvoip_json_escape "$language")\",
      \"bodyVariables\": $body_variables,
      \"headerVariables\": $header_variables,
      \"functions\": {
        \"to_flow\": $to_flow
      }
    }" \
    "$NVOIP_BASE_URL/wa/sendTemplates"
}

nvoip_send_voice_torpedo() {
  access_token="$1"
  caller="$2"
  called="$3"
  audio_message="$4"

  curl -sS \
    --request POST \
    --header "Authorization: Bearer $access_token" \
    --header "Content-Type: application/json" \
    --data-binary "{
      \"caller\": \"$(nvoip_json_escape "$caller")\",
      \"called\": \"$(nvoip_json_escape "$called")\",
      \"audios\": [
        {
          \"audio\": \"$(nvoip_json_escape "$audio_message")\",
          \"positionAudio\": 1
        }
      ],
      \"dtmfs\": []
    }" \
    "$NVOIP_BASE_URL/torpedo/voice"
}
