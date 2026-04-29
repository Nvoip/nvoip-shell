#!/bin/sh

NVOIP_BASE_URL="${NVOIP_BASE_URL:-https://api.nvoip.com.br/v2}"
NVOIP_BASIC_AUTH="TnZvaXBBcGlWMjpUblp2YVhCQmNHbFdNakl3TWpFPQ=="

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

nvoip_create_access_token() {
  nvoip_require_var NVOIP_NUMBERSIP || return 1
  nvoip_require_var NVOIP_USER_TOKEN || return 1

  response="$(curl -sS \
    --request POST \
    --header "Authorization: Basic $NVOIP_BASIC_AUTH" \
    --header "Content-Type: application/x-www-form-urlencoded" \
    --data "username=$NVOIP_NUMBERSIP&password=$NVOIP_USER_TOKEN&grant_type=password" \
    "$NVOIP_BASE_URL/oauth/token")" || return 1

  token="$(nvoip_extract_json_string "$response" access_token)"
  if [ -z "$token" ]; then
    printf '%s\n' "$response" >&2
    return 1
  fi

  printf '%s\n' "$token"
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
