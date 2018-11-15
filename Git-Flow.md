# Git CMD reference

At start of work:
- `git pull`
- `git log --graph --oneline`
	- this will let you see all work done since
- open your project and go to town!

* * *

Every time you save your work:

- `git pull`

* * *

At end of work:
- `git pull`
- `git status`
    - confirm status of your files, changes, un-tracks, etc...
- `git add [project folder name]`
    - may get message about LF-to-CRLF replacement
    - this is normal
- `git commit -m "insert brief description here"`
- `git push origin master`
- `git pull`
