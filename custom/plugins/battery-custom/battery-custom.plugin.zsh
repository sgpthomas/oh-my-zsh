###########################################
# Battery plugin for oh-my-zsh            #
# Original Author: Peter hoeg (peterhoeg) #
# Email: peter@speartail.com              #
###########################################
# Author: Sean Jones (neuralsandwich)     #
# Email: neuralsandwich@gmail.com         #
# Modified to add support for Apple Mac   #
###########################################

function battery_is_charging() {
  [[ $(acpi 2>/dev/null | grep -c 'Charging') -eq 1 ]]
}

function battery_pct() {
  if (( $+commands[acpi] )) ; then
    echo "$(acpi 2>/dev/null | cut -f2 -d ',' | tr -cd '[:digit:]')"
  fi
}

function battery_pct_remaining() {
  if [ ! $(battery_is_charging) ] ; then
    battery_pct
  else
    echo "External Power"
  fi
}

function battery_time_remaining() {
  if [[ $(acpi 2>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
    echo $(acpi 2>/dev/null | cut -f3 -d ',')
  fi
}

function battery_pct_prompt() {
  b=$(battery_pct_remaining) 
  if [[ $(acpi 2>/dev/null | grep -c '^Battery.*Discharging') -gt 0 ]] ; then
    if [ $b -gt 50 ] ; then
      color='green'
    elif [ $b -gt 20 ] ; then
      color='yellow'
    else
      color='red'
    fi
    echo "%{$fg[$color]%}$(battery_pct_remaining)%%%{$reset_color%}"
  else
    echo "∞"
  fi
}

function battery_level_gauge() {
  local gauge_slots=${BATTERY_GAUGE_SLOTS:-10};
  local green_threshold=${BATTERY_GREEN_THRESHOLD:-6};
  local yellow_threshold=${BATTERY_YELLOW_THRESHOLD:-4};
  local color_green=${BATTERY_COLOR_GREEN:-%F{65}};
  local color_yellow=${BATTERY_COLOR_YELLOW:-%F{94}};
  local color_red=${BATTERY_COLOR_RED:-%F{124}};
  local color_reset=${BATTERY_COLOR_RESET:-%{%f%k%b%}};
  local battery_prefix=${BATTERY_GAUGE_PREFIX:-'['};
  local battery_suffix=${BATTERY_GAUGE_SUFFIX:-']'};
  # local filled_symbol=${BATTERY_GAUGE_FILLED_SYMBOL:-'▶'};
  # local empty_symbol=${BATTERY_GAUGE_EMPTY_SYMBOL:-'▷'};
  local filled_symbol=${BATTERY_GAUGE_FILLED_SYMBOL:-'∿'};
  local empty_symbol=${BATTERY_GAUGE_EMPTY_SYMBOL:-'╼'};
  local charging_color=${BATTERY_CHARGING_COLOR:-'%F{green}'};
  # local charging_symbol=${BATTERY_CHARGING_SYMBOL:-'⚡'};
  local charging_symbol=${BATTERY_CHARGING_SYMBOL:-''};
  # local fade_color=${BATTERY_FADE_COLOR:-%F{243}};
  local fade_color=${BATTERY_FADE_COLOR:-%F{243}};

  local battery_remaining_percentage=$(battery_pct);

  if [[ $battery_remaining_percentage =~ [0-9]+ ]]; then
    local filled=$(((( $battery_remaining_percentage + $gauge_slots - 1) / $gauge_slots)));
    local empty=$(($gauge_slots - $filled));

    if [[ $filled -gt $green_threshold ]]; then local gauge_color=$color_green;
    elif [[ $filled -gt $yellow_threshold ]]; then local gauge_color=$color_yellow;
    else local gauge_color=$color_red;
    fi
  else
    local filled=$gauge_slots;
    local empty=0;
    filled_symbol=${BATTERY_UNKNOWN_SYMBOL:-'.'};
  fi

  if battery_is_charging; then
    local gauge_color=$charging_color;
  fi

  printf ${fade_color//\%/\%\%}${battery_prefix//\%/\%\%}${gauge_color//\%/\%\%}
  printf ${filled_color}${filled_symbol//\%/\%\%}'%.0s' {1..$filled}${color_reset}
  [[ $filled -lt $gauge_slots ]] && printf ${empty_symbol//\%/\%\%}'%.0s' {1..$empty}
  printf ${color_reset//\%/\%\%}${fade_color//\%/\%\%}${battery_suffix//\%/\%\%}${color_reset//\%/\%\%}
}


