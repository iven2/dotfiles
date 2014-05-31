# a count down timer
# $1 holds the total minutes to be counted, and $2 holds the interval in minutes
# to display each countdown($2 is optional)
countdown(){
    if [[ ${#} <  1 ]] ; then
        echo "Usage: countdown total_time_in_minutes [ interval_in_minutes ]"
        return 66
    fi
    local total_seconds=$(($1 * 60))
    if [ -z $2 ]; then
        local display_interval=60
    else
        local display_interval=$(($2 * 60))
    fi
    # $() expression should be used instead of backtick
    # because backtick is grave
    # $ can always show us some substitution is happening
    # details are saved in my evernotes
    echo "Countdown started & current time is" $(date)
    until [[ $total_seconds -le 0 ]]; do
        echo $((total_seconds / 60)) "minutes left."
        tmp_total_seconds=$((total_seconds - display_interval))
        if [[ tmp_total_seconds -gt 0 ]]; then
            sleep $display_interval
            total_seconds=$tmp_total_seconds
        else
            sleep $total_seconds
            total_seconds=0
        fi
    done
    echo "Countdown ended & current time is" $(date)
}


# this function is only needed for ubuntu 14.xx because of gnu screen update
# this is used for Screen version 4.01.00devel (GNU) 2-May-06
# for now, this is only need for digital ocean server
set_screen_focus_binding(){
    screen -X bindkey '^[[Z' focus prev
}

alias op='cd ~/open-times/backend/opentimes'
