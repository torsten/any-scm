# Any SCM

Use Git, Subversion and Mercurial via the same set of commands.

The basic concepts in pretty much any SCM software are the same: you add files, you commit, you diff, and so on.  Unfortunately, it is easy to forget which SCM you are using currently, `any-scm` solves this.

`any-scm` provides the following commands which will do the right thing, depending which SCM is active in the current folder:

  * `add` adds a file to version control
  * `ci` commits a new revision
  * `up` get the newest updates from the central repository.  
  * `st` list the status of the working copy
  * `revert` restores a file to the version from the last commit
  * `diff` shows a diff of all current changes


## Why?

Some time ago, I adopted Git.  Coming from Subversion, I had some aliases for the most used commands in my <code>.zshrc</code> for working with <code>svn</code>.  But since I had to continue to work with those old Subversion repositories and still wanted to have the same convenience commands for the fancy new Git, I came up with this tiny script and created a bunch of symlinks to it instead of using shell aliases.

It detects from its arguments and CWD if you are working with a Git or Subversion repository and then chooses to execute the right command.


## Installation

Add <code>~/bin/</code> to your `PATH`, then copy all the files and links into <code>~/bin/</code>.
