#!/bin/bash

#
# here document
#

# A here document is a special-purpose code block. It uses a form of I/O 
# redirection to feed a command list to an interactive program or a command, 
# such as ftp, cat, or the ex text editor.
# from : http://www.tldp.org/LDP/abs/html/here-docs.html

cat <<!EOF!
	stay foolish, stay hungry
	come on!
	you can do it.
!EOF!
#  Replacing line 12, above, with
#+   cat > $Newfile <<End-of-message
#+       ^^^^^^^^^^
#+ writes the output to the file $Newfile, rather than to stdout.

# The - option to mark a here document limit string (<<-LimitString) suppresses 
# leading tabs (but not spaces) in the output. This may be useful in making a 
# script more readable.
cat <<-!EOF!
	stay foolish, stay hungry
	come on!
	you can do it.
!EOF!

# using replace variable in heredocument
NAME="hongjin.cao"
RESPONDENT="JLU"
cat <<Endofmessage
Hello, there, $NAME.
Greetings to you, $NAME, from $RESPONDENT.
# This comment shows up in the output (why?).
Endofmessage

# Parameter substitution turned off
NAME="John Doe"
RESPONDENT="the author of this fine script"  
cat <<'Endofmessage'
Hello, there, $NAME.
Greetings to you, $NAME, from $RESPONDENT.
Endofmessage
#   No parameter substitution when the "limit string" is quoted or escaped.
#   Either of the following at the head of the here document would have
#+  the same effect.
#   cat <<"Endofmessage"
#   cat <<\Endofmessage

# generate another file (shell,c,python....)
# use redirect
OUTFILE=genetated.sh
(
cat <<'EOF'
#!/bin/bash

echo "This is a generated shell script."
#  Note that since we are inside a subshell,
#+ we can't access variables in the "outside" script.

echo "Generated file will be named: $OUTFILE"
#  Above line will not work as normally expected
#+ because parameter expansion has been disabled.
#  Instead, the result is literal output.

a=7
b=3

let "c = $a * $b"
echo "c = $c"

exit 0
EOF
) > $OUTFILE

