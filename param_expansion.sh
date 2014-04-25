#！/bin/bash

#
# Parameter Expansion 
# 详解见Linux程序设计 chp2 Parameter Expansion
#


unset foo
echo ${foo:-bar}
foo=fud
echo ${foo:-bar}
echo "length:${#foo}"
foo=/usr/bin/X11/startx
echo ${foo#*/}
echo ${foo##*/}
bar=/usr/local/etc/local/networks
echo ${bar%local*}
echo ${bar%%local*}

unset foo
echo ${foo:=bar}
echo $foo
echo ${foo:=fud}

unset foo
foo=bar
echo ${foo:+fud}

unset foo
echo ${foo:?bar}

exit 0
#
# Parameter Expansion Description
# ${param:-default} If param is null, then set it to the value of default.
# ${#param}			Gives the length of param
# ${param%word}		From the end, removes the smallest part of param that
#					matches word and returns the rest
# ${param%%word}	From the end, removes the longest part of param that
#					matches word and returns the rest
# ${param#word}		From the beginning, removes the smallest part of param that
#					matches word and returns the rest
# ${param##word}	From the beginning, removes the longest part of param that
#					matches word and returns the rest
# 
# ${foo:=bar}		however, would set the variable to $foo. This string operator checks
#					that foo exists and isn’t null. If it isn’t null, then it returns its value, but otherwise
#					it sets foo to bar and returns that instead.
# ${foo:?bar}		will print foo: bar and abort the command if foo doesn’t exist or is
#					set to null. 
# ${foo:+bar}		returns bar if foo exists and isn’t null. What a set of choices!
#
