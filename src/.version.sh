#!/bin/sh

LC_ALL=C
export LC_ALL

extra=""
if test -d .svn
then
	revision=`svn info | grep "^Last Changed Rev:" | cut -f 2 -d ':' | tr -d ' '`
	year=`svn info | grep "^Last Changed Date:" | cut -f 4 -d ' ' | cut -f 1 -d '-'`
	month=`svn info | grep "^Last Changed Date:" | cut -f 4 -d ' ' | cut -f 2 -d '-'`
	day=`svn info | grep "^Last Changed Date:" | cut -f 4 -d ' ' | cut -f 3 -d '-'`
	hour=`svn info | grep "^Last Changed Date:" | cut -f 5 -d ' ' | cut -f 1 -d ':'`
	minute=`svn info | grep "^Last Changed Date:" | cut -f 5 -d ' ' | cut -f 2 -d ':'`

	src="svn"
elif test -d ../../.git
then
	# Lets assume that we are building from something which tracks the
	# master branch, which is known to carry git-svn information
	branch_point=$(git merge-base master HEAD)
	
	# extract information about that point
	# NB I bet there are better ways ... ;)
	#	 if we went pure git way, git describe would have been sufficient
	dateinfo=$(git show --pretty='format:%aD' $branch_point | head -1)

	year=`date -d "$dateinfo" +%Y`
	month=`date -d "$dateinfo" +%m`
	day=`date -d "$dateinfo" +%d`
	hour=`date -d "$dateinfo" +%H`
	minute=`date -d "$dateinfo" +%M`

	revision=$(git show --pretty='format:%b' $branch_point | head -1 | sed -e 's/.*@\([0-9]*\) \S*$/\1/g')
	extra="git:`git show --pretty='format:%h'|head -1`"
else
	extra="UNKNOWN_VERSION"
	revision=9999

	year="9999"
	month="99"
	day="99"
	hour="99"
	minute="99"
	src="custom"
fi

date="$year-$month-$day"
time="$hour:$minute"

if test "$1" ; then
	extra="_$1"
fi

echo "#define VERSION_EXTRA \"${extra}\""
echo "#define VERSION_REVISION ${revision}"
echo "#define VERSION_RELEASE \"svn_r${revision}_${date}_${time}_${extra}\""
echo "#define VERSION_YEAR `echo ${year} | sed 's/^[0]//g'`"
echo "#define VERSION_MONTH `echo ${month} | sed 's/^[0]//g'`"
echo "#define VERSION_DAY `echo ${day} | sed 's/^[0]//g'`"
echo "#define VERSION_HOUR `echo ${hour} | sed 's/^[0]//g'`"
echo "#define VERSION_MINUTE `echo ${minute} | sed 's/^[0]//g'`"
