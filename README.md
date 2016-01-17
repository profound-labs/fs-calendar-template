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

## Config and Moonday data

Edit `data/config.csv`.

Generate the uposatha and astro moondays:

    make get-moondays
    make get-astromoondays

## Year planner

At this point the year planner should alread work:

    make planner-a4

## Add the photos

First, unlock `src-images/jpg` to allow changing the files:

    git annex unlock src-images/jpg

Copy the new photos to `src-images/jpg`. Delete the placeholder small .jpg
files, rename the new image files to month names.

```
git annex add src-images/jpg
git commit -m "added photos"
```

Now git-annex locked and symlinked them.

## Convert the photos

```
git annex unlock src-images
cd src-images
./convert-jpg.sh
```

Run `make wall` to compile the wall PDF and see if the images work.

Crop the thumbs, use square sizes:

    cp jpg/*.jpg jpg-thumbs-crops
    gimp jpg-thumbs-crops/January.jpg
    ...
    ./convert-thumbs.sh

Run `make wall-and-desk` to and see if the thumbs work.

Add and commit the changes:

```
git annex add src-images
git commit -m "cropped and coverted thumbs"
```

# Add the quotes

Add the quotes in `english-text.tex`.

# Cover art

Copy `\coverPageWall` and `\coverPageDesk` from `calendar-layout.sty`, and renew
in `english-text.tex` at `\PreLayoutSettings`.

# Send preview PDFs for checking

# Prepare the text for the translators

Use docx. More than one file of the same thing is confusing. LibreOffice will
open .docx too, but Office won't do with .odt.

Copy the English-YYYY.docx from last year to doc/ and copy in the new text.

# Preflight checklist

# Wrapping up

Copy and commit wallcalendar.cls

# Any Other Business?

    pt -e 'TODO|FIXME'
