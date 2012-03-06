#!/bin/bash -
#
# File:        git-archive-all.sh
#
# Description: A utility script that builds an archive file(s) of all
#              git repositories and submodules in the current path.
#              Useful for creating a single tarfile of a git super-
#              project that contains other submodules.
#
# Examples:    Use git-archive-all.sh to create archive distributions
#              from git repositories. To use, simply do:
#
#                  cd $GIT_DIR; git-archive-all.sh
#
#              where $GIT_DIR is the root of your git superproject.
#
# License:     GPL3
#
###############################################################################
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
###############################################################################

# DEBUGGING
set -e
set -C # noclobber

# TRAP SIGNALS
trap 'cleanup' QUIT EXIT

# For security reasons, explicitly set the internal field separator
# to newline, space, tab
OLD_IFS=$IFS
IFS='
 	'

function cleanup () {
    rm -f $TMPFILE
    rm -f $ACCUM
    rm -f $TOARCHIVE
    IFS="$OLD_IFS"
}

function usage () {
    echo "Usage is as follows:"
    echo
    echo "$PROGRAM <-v>"
    echo "    Prints the program version number on a line by itself and exits."
    echo
    echo "$PROGRAM <-h>"
    echo "    Prints this usage output and exits."
    echo
    echo "$PROGRAM [-p <prefix_path>] [-c <treeish>]"
    echo "    Creates an archive for the entire git superproject, and its submodules"
    echo "    using the passed parameters, described below."
    echo
    echo "    If '-p' is specified, the archive's superproject and all submodules"
    echo "    are created with the <path> prefix named. The default is to not use one."
    echo
    echo "    If '-c' is specified, the archive is rooted at the TREEISH path given."
}

function version () {
    echo "$PROGRAM version $VERSION"
}

# Internal variables and initializations.
readonly PROGRAM=`basename "$0"`
readonly VERSION=0.2

OLD_PWD="`pwd`"
TMPDIR=${TMPDIR:-/tmp}
ACCUM=`mktemp "$TMPDIR/accumulation.XXXXX"` # Create a place to make a super-tar
TMPFILE=`mktemp "$TMPDIR/$PROGRAM.XXXXXX"` # Create a place to store our work's progress
TOARCHIVE=`mktemp "$TMPDIR/$PROGRAM.toarchive.XXXXXX"`

FORMAT=tar
TREEISH=HEAD
while getopts "p:c:vh" opt; do
  case $opt in
    h)
      usage
      exit
      ;;
    v)
      version
      exit
      ;;
    p)
      PREFIX="$OPTARG"
      ;;
    c)
      TREEISH="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# RETURN VALUES/EXIT STATUS CODES
readonly E_BAD_OPTION=254
readonly E_UNKNOWN=255

# Validate parameters; error early, error often.
if [ `git config -l | grep -q '^core\.bare=false'; echo $?` -ne 0 ]; then
    echo "$PROGRAM must be run from a git working copy (i.e., not a bare repository)."
    exit
fi

# Create the superproject's git archive
git archive --format=$FORMAT --prefix="$PREFIX" $TREEISH >| $ACCUM # why do you make me clobber you?
echo $ACCUM >| $TMPFILE

# find all '.git' dirs, these show us the remaining to-be-archived dirs
find . -name '.git' -type f -print | sed -e 's/^\.\///' -e 's/\.git$//' | (grep -v '^$' || echo -n) >> $TOARCHIVE

while read path; do
    TREEISH=$(git submodule | grep "^ .*${path%/} " | cut -d ' ' -f 2) # git submodule does not list trailing slashes in $path
    cd "$path"
    git archive --format=$FORMAT --prefix="${PREFIX}$path" ${TREEISH:-HEAD} > "$TMPDIR"/"$(echo "$path" | sed -e 's/\//./g')"$FORMAT
    echo "$TMPDIR"/"$(echo "$path" | sed -e 's/\//./g')"$FORMAT >> $TMPFILE
    cd "$OLD_PWD"
done < $TOARCHIVE

# Concatenate archives into a super-archive.
if [ $FORMAT == 'tar' ]; then
    sed -e '1d' $TMPFILE | while read file; do
        tar --concatenate -f "$ACCUM" "$file" && rm -f "$file"
    done
fi

cat $ACCUM
