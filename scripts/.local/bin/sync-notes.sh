#!/run/current-system/sw/bin/bash

NOTES_DIR="$HOME/notes/home"

cd "$NOTES_DIR" || exit 1

git pull --rebase origin master

if [[ -n $(git status -s) ]]; then
    echo "Changes detected, syncing..."
    git add .
    git commit -m "Auto-sync: $(date +'%Y-%m-%d %H:%M:%S')"
    git push origin master
else
    echo "No changes to sync."
fi
