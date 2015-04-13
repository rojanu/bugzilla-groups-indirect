Add page to show groups who have indirect access to other groups
## Installation==
* Download the latest release.
* Unpack the download. This will create a directory called "GroupsIndirect".
* Move the "GroupsIndirect" directory into the "extensions" directory in your Bugzilla installation.
Go to your Bugzilla directory
Apply the patch and run checksetup.pl
```
patch -p0 -i extensions/GroupsIndirect/patch-4.x.diff
./checksetup.pl
```
