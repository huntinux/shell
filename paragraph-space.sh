#!/bin/bash
# paragraph-space.sh
# Ver. 2.1, Reldate 29Jul12 [fixup]

# Inserts a blank line between paragraphs of a single-spaced text file.
# Usage: $0 FILENAME

MINLEN=60        # Change this value? It's a judgment call.
#  Assume lines shorter than $MINLEN characters ending in a period
#+ terminate a paragraph. See exercises below.

origin(){
	while read line  # For as many lines as the input file has ...
	do
	  echo "$line"   # Output the line itself.
	
	  len=${#line}
	  if [[ "$len" -lt "$MINLEN" && "$line" =~ [*{\.}]$ ]]
	# if [[ "$len" -lt "$MINLEN" && "$line" =~ \[*\.\] ]]
	# An update to Bash broke the previous version of this script. Ouch!
	# Thank you, Halim Srama, for pointing this out and suggesting a fix.
	    then echo    #  Add a blank line immediately
	  fi             #+ after a short line terminated by a period.
	done < $1
}

# Exercises:
# ---------
#  1) The script usually inserts a blank line at the end
#+    of the target file. Fix this.
#  2) Line 17 only considers periods as sentence terminators.
#     Modify this to include other common end-of-sentence characters,
#+    such as ?, !, and ".

exercise1(){
	
	# get total line number
	file=$1
	linenum=`wc -l $file | cut -d' ' -f1`

	curlinenum=0
	while read line
	do
		echo "$line"
		let curlinenum++
		len=${#line}
		if [[ "$len" -lt "$MINLEN" && "$line" =~ [*{\.}]$ && "$curlinenum" -lt "$linenum" ]]
		then
			echo 
		fi
	done < $file
}

exercise2(){
	# get total line number
	file=$1
	linenum=`wc -l $file | cut -d' ' -f1`

	curlinenum=0
	while read line
	do
		echo "$line"
		let curlinenum++
		len=${#line}
		if [[ "$len" -lt "$MINLEN" && ( "$line" =~ [*{\.}]$ || "$line" =~ [*{\!}]$ || "$line" =~ [*{\?}]$ || "$line" =~ [*{\"}]$ ) && "$curlinenum" -lt "$linenum" ]]
		then
			echo 
		fi
	done < $file

}


# start
file=${1:-"./book"}
#origin $file
#exercise1 $file
exercise2 $file
