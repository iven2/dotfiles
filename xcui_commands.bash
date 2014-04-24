# a count down timer
# $1 holds the total seconds to be counted, and $2 holds the interval in seconds
# to display each countdown($2 is optional)
countdown(){
    local total_seconds=$1
    if [ -z $2 ]; then
        local display_interval=60
    else
        local display_interval=$2
    fi
    # $() expression should be used instead of backtick
    # because backtick is grave
    # $ can always show us some substitution is happening
    # details are saved in my evernotes
    echo "current time is" $(date)
    while [[ $total_seconds > 0 ]]; do
        echo $total_seconds "seconds left."
        total_seconds=$((total_seconds - display_interval))
        sleep $display_interval
    done
    echo "current time is" $(date)
}
