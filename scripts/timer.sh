#
# File Key / Value storage + timer
# https://unix.stackexchange.com/questions/21943/standard-key-value-datastore-for-unix
#

SANG_STORAGE='.sang_storage'
mkdir -p "$HOME/$SANG_STORAGE"

s_put () { key=$1; value=$2; printf %s "$value" >| "$HOME/$SANG_STORAGE/$key"; }
s_get () { key=$1; cat "$HOME/$SANG_STORAGE/$key"; }
s_remove () { key=$1; rm -f "$HOME/$SANG_STORAGE/$key"; }
s_exist () {
  key=$1

  [[ -f "$HOME/$SANG_STORAGE/$key" ]]
}


now () { date +"%s"; }

pomo_start () {
  # Add the timestamp of current time + 25 mins
  s_put pomo $(($(now) + 25*60))
}

pomo_remaining () {
  echo $((($(s_get pomo) - $(now)) / 60))
}


pomo_finished () {
  if (( $(now) > $(s_get pomo) ))
  then
    true
  else
    false
  fi
}

pomo_notify () {
  /usr/local/bin/terminal-notifier -message "Done" -title "$(date +'%H:%M') Pomo ended"
}

pomo_kill () {
  s_remove pomo
  pomo_notify
}

pomo_check () {
  if ! s_exist pomo
  then
    echo ''  # not started
    return
  fi

  if pomo_finished
  then
    pomo_kill
    echo "Pomo finished"
  else
    echo "$(pomo_remaining)m"
  fi
}
