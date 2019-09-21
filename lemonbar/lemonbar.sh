#!/bin/bash

# ==============================================================================
# ======================   Setup   =============================================
# ==============================================================================

killall -q limebar

fifo_pipe=/tmp/limebar_refresh
[ -p $fifo_pipe ] && mkfifo $fifo_pipe

wm_name=$(wmctrl -m             \
  | awk -F: 'NR==1 {print $2}'  \
  | sed -e 's/\ //'             \
  | tr '[:upper:]' '[:lower:]')

number_of_displays=$(xrandr -d :0 -q \
  | rg ' connected'                  \
  | wc -l                            \
  | xargs echo -1+ | bc)

# ==============================================================================
# ======================   Utilities   =========================================
# ==============================================================================

color() { xrdb -query | rg color"$1": | awk '{print $2}'; }

log() { echo "$(date +'%Y/%m/%d-%H:%M:%S')" - "$@" >> /tmp/lime_shell.log; }

refresh() { for mod in $@; do mod_"$mod"; done }

generate_bar() {
  bar=$("${wm_name}"_bar)
  echo $(seq 0 "$number_of_displays" | sed "s/.*/%{S&}$bar/")
  # for i in $(seq 0 $number_of_displays); do
  #   echo -n %{S${i}}${bar//[$'\n']/ }
  # done
}

# ==============================================================================
# ======================   Daemons   ===========================================
# ==============================================================================

# TODO: vpn
# TODO: internet connection
# TODO: network device (ethernet/wifi)
# TODO: workspace
# TODO: active window

daemon_clock() {
  while true; do
    refbar clock
    sleep 1m
  done
}

# ==============================================================================
# ======================   Modules   ===========================================
# ==============================================================================

mod_clock() {
  clock="%{F$(color 4)}$(date +'%H:%M') %{F$(color 7)}$(date +'%b %d')"
}

mod_internet() {
  # vpn status
  if [ "$(nordvpn status | rg Status | cut -d' ' -f2)" = "Connected" ]; then
    vpn="%{F$(color 4)}"
  fi

  # connection type
  case "$(route | rg '192.168.1.0' | awk '{ print substr($NF,1,1) }')" in
    e) connection="ethernet" ;;
    w) connection="wifi"     ;;
    *) connection="??"       ;;
  esac

  # assign to internet and reset color
  internet="${vpn}${connection}%{F$(color 7)}"
}

mod_workspaces() {
  curr_ws=$(wmctrl -d | rg '\*' | awk '{print $1}')
  workspaces=$(wmctrl -d \
    | awk '{printf "%%{A:wmctrl -s %s && refbar workspaces windows:}%s%%{A}\n", NR-1, $NF}' \
    | sed $((curr_ws+1))"s/.*/%{F$(color 4)}&%{F$(color 7)}/")
}

# Display the current active windows for this workspace
# TODO: Accent the current window. (How to cover all cases of selection?)
mod_windows() {
  workspace=$(wmctrl -d | rg '\*' | cut -d' ' -f1)
  windows=$(wmctrl -l \
    | awk '{ if ($2 == w) printf "%%{A:wmctrl -i -a %s:}%s%%{A}\n", $1, $NF }' \
      w="$workspace")
}

# ==============================================================================
# ======================   WM Specific   =======================================
# ==============================================================================

openbox_initialize_modules() {
  daemon_clock &
  refbar workspaces windows clock internet
}
openbox_bar() {
  echo %{l}${workspaces} ${windows}%{c}${clock}%{r}${internet}
}

# ==============================================================================
# ======================   Run   ===============================================
# ==============================================================================

"${wm_name}"_initialize_modules

while read -r line < $fifo_pipe; do
  refresh "$line"
  generate_bar
done | limebar
