# Any SCM

I recently adopted Git.  Coming from Subversion, I had some aliases for the most used commands in my <code>.zshrc</code> for working with Subversion.  But since I have to continue to work with those old Subversion repositories and still want to have the same convenience commands for the fancy new Git, I came up with this tiny script.

It detects from its arguments if you are working with a Git or Subversion repository and then chooses to execute the right command.  Currently there is support for this commands:

* <code>add</code>
* <code>ci</code> (commit)
* <code>st</code> (status)
* <code>revert</code> (revert in Subversion and checkout in Git)


## Installation

Copy all the files and links into <code>~/bin/</code>.
