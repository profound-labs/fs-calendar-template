# Forest Sangha Calendar template

Using the [wallcalendar](https://github.com/profound-labs/wallcalendar) documentclass.

See the guide at the [github wiki](https://github.com/profound-labs/fs-calendar/wiki) for production how-tos.

## Starting a new year

```
git clone ./fs-calendar-template ./2017
cd 2017
rm .git -rf

git init
git annex init "2017 calendar"

git annex add src-images pdf-keep --include-dotfiles
git add -A .

git commit -am "kickstart"
```
