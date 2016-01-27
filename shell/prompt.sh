
#print your terminal's ANSI colors for codes 0-256
print_colors () {
    ( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )
}

prompt_command () {
    BLACK=$(tput setaf 0)
    WHITE=$(tput setaf 15)
    OFFWHITE=$(tput setaf 255)
    NORMAL=$(tput sgr0)
    GREEN=$(tput setaf 2)

    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERRPROMPT=" "
    else
        ERRPROMPT='-&gt;($?) '
    fi

    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi

    local gitbranch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\* \1 /'`

    local TIME=`date +"%l:%M:%S$meridiem"|sed 's/ //g'`
    local myprompt="\[${OFFWHITE}\]_________________________________________________________\n"
    myprompt=$myprompt"[\u@\h ${TIME}]$ERRPROMPT \w\n"
    myprompt=$myprompt"\[${GREEN}\]${gitbranch}\[${OFFWHITE}\]> \[${NORMAL}\]"

    export PS1=$myprompt
}
PROMPT_COMMAND=prompt_command


