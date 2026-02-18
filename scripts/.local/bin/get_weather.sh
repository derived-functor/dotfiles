#! /bin/bash
set -e

declare -A weather_codes

weather_codes["0"]="󰖙"
weather_codes["1"]="󰖕"
weather_codes["2"]="󰖕"
weather_codes["3"]="󰖐"
weather_codes["45"]="󰖑"
weather_codes["48"]="󰖑"
weather_codes["51"]="󰖗"
weather_codes["53"]="󰖗"
weather_codes["55"]="󰖗"
weather_codes["61"]="󰖖"
weather_codes["63"]="󰖖"
weather_codes["65"]="󰖖"
weather_codes["71"]="󰼶"
weather_codes["73"]="󰼶"
weather_codes["75"]="󰼶"
weather_codes["77"]="󰼶"
weather_codes["80"]="󰖗"
weather_codes["81"]="󰖗"
weather_codes["82"]="󰖗"
weather_codes["85"]="󰼶"
weather_codes["86"]="󰼶"
weather_codes["95"]="󰖓"
weather_codes["96"]="󰖒"
weather_codes["99"]="󰖒"

BASE_URL="https://api.open-meteo.com"
ENDPOINT="v1/forecast"

LAT="${LATITUDE:-"57.75"}"
LON="${LONGITUDE:-"37.62"}"
CURRENT="temperature_2m,wind_speed_10m,precipitation,weather_code"
TIMEZONE="Europe%2FMoscow"

request_url="$BASE_URL/$ENDPOINT?latitude=$LAT&longitude=$LON&current=$CURRENT&timezone=$TIMEZONE"

json=$(curl -fs $request_url)

timezone=$(echo $json | jq -r ".timezone")
time_iso=$(echo $json | jq -r ".current.time")
time_=$(LC_TIME=C date -d "$time_iso" "+%d.%m.%Y %I:%M %p")

temperature_unit=$(echo $json | jq -r ".current_units.temperature_2m")
windspeed_unit=$(echo $json | jq -r ".current_units.wind_speed_10m")

temperature="$(echo $json | jq -r '.current.temperature_2m')"
windspeed="$(echo $json | jq -r '.current.wind_speed_10m')"

weather_code=$(echo $json | jq -r ".current.weather_code")
weather_icon="${weather_codes[$weather_code]}"

echo "$time_ ($timezone)|||$temperature $temperature_unit|||$windspeed $windspeed_unit|||$weather_icon"
