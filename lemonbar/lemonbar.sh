#!/bin/sh

# ==============================================================================
# ======================   Setup   =============================================
# ==============================================================================

killall -q lemonbar

fifo_pipe=/tmp/lemonbar_refresh
if [[ ! -p $fifo_pipe ]]; then
  mkfifo $fifo_pipe
fi

wm_name=$(wmctrl -m             \
  | awk -F: 'NR==1 {print $2}'  \
  | sed -e 's/\ //'             \
  | tr '[:upper:]' '[:lower:]')

# number_of_displays=$(xrandr -d :0 -q \
#   | rg ' connected'                  \
#   | wc -l                            \
#   | xargs echo -1+                   \
#   | bc)
number_of_displays=$(xrandr -d :0 -q \
  | rg ' connected'                  \
  | wc -l)
number_of_displays="$(($number_of_displays-1))"

# ==============================================================================
# ======================   Utilities   =========================================
# ==============================================================================

function color() { echo $(xrdb -query | rg color$1: | awk '{print $2}') }

function log() { echo $(date +'%Y/%m/%d-%H:%M:%S') - "$@" >> /tmp/lemon.log }

function join_by { local IFS="$1"; shift; echo "$*"; }

# TODO: make clock daemon
function refresh() { mod_clock; for mod in "$@"; do mod_$mod; done }

function generate_bar() {
  # seq 0 $number_of_displays \
  #   | awk '{ printf "\%{S%d}'$(${wm_name}_bar)'\n", $1 }' \
  #   | xargs join_by ' '
  for i in $(seq 0 $number_of_displays); do
    final_bar="${final_bar}%{S$i}$(${wm_name}_bar)"
  done
  
  echo $final_bar
}

# ==============================================================================
# ======================   Modules   ===========================================
# ==============================================================================

function mod_clock() {
  clock="%{F$(color 4)}$(date +'%H:%M') %{F$(color 7)}$(date +'%b %d')"
}

function mod_internet() {
  #TODO: trigger updates on vpn and connection status change
  internet=""

  # vpn status
  if [[ $(nordvpn status | rg Status | cut -d' ' -f2) == Connected ]]; then
    internet="$internet%{F$(color 4)}"
  fi

  # connection type
  local connection=$(route | rg '192.168.1.0' | awk '{ print $NF }' | head -c 1)
  case $connection in
    e) internet="${internet}ethernet" ;;
    w) internet="${internet}wifi"     ;;
    *) internet="${internet}??"       ;;
  esac

  # reset colors and assign to internet
  internet="$internet%{F$(color 7)}"
}

function mod_workspaces() {
  workspaces=""
  local current_workspace=$(wmctrl -d | rg '\*' | awk '{print $1}')
  for index ws in $(wmctrl -d | awk '{print NR-1,$NF}'); do
    ws_fmt="%{A:wmctrl -s $index && refbar workspace windows:}$ws%{A}"
    if [ "$index" -eq "$current_workspace" ]; then
      workspaces="$workspaces %{F$(color 4)}$ws_fmt%{F$(color 7)}"
    else
      workspaces="$workspaces $ws_fmt"
    fi
  done
  # ws_fmt="\%{A:wmctrl -s %d && refbar workspace windows:}%s\%{A}\n"
  # color_wrap="%{F$(color 4)}&%{F$(color 7)}"
  # workspaces=$(wmctrl -d \
  #   | awk '{printf '$ws_fmt', NR-1, $NF}' \
  #   | sed $current_workspace's/.*/'$color_wrap'/' \
  #   | xargs join_by ' ')
  log $workspaces
}

# Display the current active windows for this workspace
# TODO: Accent the current window. (How to cover all cases of selection?)
function mod_windows() {
  windows=""
  function get_window_name() {
    echo $(xdotool getwindowname $1 | awk -F- '{print $NF}' | sed -e 's/\ //')
  }
  function button_command() {
    echo wmctrl -i -a $1
  }

  workspace=$(wmctrl -d | rg '\*' | cut -d' ' -f1)
  window_ids=$(wmctrl -l \
              | awk '{ if ($2 == w) { print } }' w=$workspace \
              | cut -d' ' -f1)

  [[ -z $window_ids ]] && return

  #TODO: write into array and python-join over " "
  while read id; do
    windows="${windows}%{A:$(button_command $id):}$(get_window_name $id)%{A} "
  done <<< $window_ids
}

# ==============================================================================
# ======================   WM Specific   =======================================
# ==============================================================================

function openbox_initialize_modules() {
  refbar workspaces windows clock internet
}
function openbox_bar() {
  echo %{l}${workspaces} ${windows}%{c}${clock}%{r}${internet}
}

# ==============================================================================
# ======================   Run   ===============================================
# ==============================================================================

${wm_name}_initialize_modules

while read line < $fifo_pipe; do
  refresh $line
  # TODO: different behavior from calling generate_bar directly?
  bar=$(generate_bar)
  log $bar
  echo $bar
done \
  | lemonbar \
      -p \
      -f 'Gohu GohuFont' \
      -B $(color 0) \
      -a 100 \
      -g 5760x20+0+0 \
  | while read line; do eval $line; done
