set --global tide_left_prompt_item_separator_same_color " | "
set --global tide_left_prompt_item_separator_same_color_color brwhite
set --global tide_left_prompt_pad_items false
set --global tide_left_prompt_suffix ""

function _tide_item_battery
    # Check whether battery is present
    if [ ! (command -v upower) ] || [ -z (upower -e 2>&1 | grep 'BAT') ]
        return
    end

    set -l acpi (command acpi --battery 2>/dev/null | head -n1)
    set -l batt (string match -r '\d+%' $acpi | string trim -c '%')
    set -l batt_state_color

    test -z $batt; and return
    test $batt -gt 99; and return

    if string match -q '*Discharging*' $acpi
        set batt_status 'discharging'
    else
        set batt_status 'charging'
    end

    if [ $batt -gt 75 ]
        set_color brgreen
        if [ $batt_status = 'charging' ]
            printf '\xef\x96\x89'
        else
            printf '\xef\x95\xb8'
        end
    else if [ $batt -ge 75 ]
        set_color green
        if [ $batt_status = 'charging' ]
            printf '\xef\x96\x89'
        else
            printf '\xef\x95\xbf'
        end
    else if [ $batt -ge 50 ]
        set_color yellow
        if [ $batt_status = 'charging' ]
            printf '\xef\x96\x87'
        else
            printf '\xef\x95\xbd'
        end
    else if [ $batt -ge 25 ]
        set_color bryellow
        if [ $batt_status = 'charging' ]
            printf '\xef\x96\x86'
        else
            printf '\xef\x95\xba'
        end
    else
        set_color brred
        if [ $batt_status = 'charging' ]
            printf '\xef\x96\x85'
        else
            printf '\xef\x95\xb9'
        end
    end
    printf ' %2d%% ' $batt
end

set --global tide_left_prompt_items \
    "time" \
    "pwd" \
    "git" \
    "cmd_duration" \
    "newline" \
    "context" \
    "character"

set --global tide_right_prompt_items \
    "status" \
    "battery" \
    "jobs"
