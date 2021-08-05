(
    IFS='
    '
    for x in `xrandr | grep " connected" | cut -f1 -d " "`;
    do (
        # TODO: get brightness of monitor x, not just first monitor
        brightness=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`;
        step="0.1";
        if [ $1 == "up" ] 
        then 
            newbrightness=`python3 -c "print(round($brightness + $step, 1))"`;
            echo "increasing brightness on $x from $brightness to $newbrightness";
        elif [ $1 == "down" ]
        then
            newbrightness=`python3 -c "print(round($brightness - $step))"`;
            echo "decreasing brightness on $x from $brightness to $newbrightness";
        else
            newbrightness=$1;
            echo "setting brightness on $x from $brightness to $newbrightness";
        fi
        xrandr --output $x --brightness $newbrightness;
    )
    done
)
