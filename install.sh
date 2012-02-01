#!/bin/sh

if [[ -d $1 ]]; then
	abs_path=$(cd "$(dirname "$0")" && pwd)
	any_scm="$abs_path/any-scm.rb"
	
	echo "Creating links to $any_scm...\n"
	ln -vs "$any_scm" "$1/st"
	ln -vs "$any_scm" "$1/add"
	ln -vs "$any_scm" "$1/ci"
	ln -vs "$any_scm" "$1/revert"
	ln -vs "$any_scm" "$1/up"
	ln -vs "$any_scm" "$1/diff"
	echo "Done.

Note: You might want to add a alias like
      alias diff='$1/diff'
      to your shell's config to execute the correct diff command.
"

else
	echo "Usage: $0 DIRECTORY

\tDIRECTORY is the directory where to create the symlinks to any-scm.rb.
\t          Usually this should be ~/bin or /usr/local/bin.
"
fi
