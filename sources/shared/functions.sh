#############
# FUNCTIONS #
#############

# TODO: make this environment specfic
function fixup() {
    put_command "FIXUP";
    git checkout -- yarn.lock;
    put_note "Adding all unstaged files";
    git add -u;
    put_note "Committing Fixup";
    git commit -m "fixup";
    put_note "Rebasing";
    git rebase -i $(git rev-parse --abbrev-ref --symbolic-full-name @{u});
}

# TODO: set up .colorrc and yank these tput calls

from_master() {
    # TODO: get name of previous branch

    CMD=$(echo -e "\n$(tput setaf 2)[COMMAND]$(tput bold)");
    RESET=$(tput sgr0);

    echo -e "$CMD Checking out yarn.lock $RESET";
    git checkout -- yarn.lock;

    echo -e "$CMD Stashing changes $RESET";
    git stash;

    echo -e "$CMD Checking out previous branch $RESET";
    git checkout -;

    echo -e "$CMD Pop stashed changes $RESET";
    git stash pop;

    echo -e "$CMD Detect NPM version with NVM$RESET";
    nvm use;

    echo -e "$CMD Build dependencies with Yarn$RESET";
    yarn install;

    echo -e "$CMD Build dependencies with Bower$RESET";
    bower install;

    echo -e "$CMD Rebuild node-sass with native extensions $RESET";
    npm rebuild node-sass;

    echo;
    echo -e "$(tput setaf 2) *** Switched to previous branch *** $RESET";
    git status;
}

to_master() {
    CMD=$(echo -e "\n$(tput setaf 2)[COMMAND]$(tput bold)");
    RESET=$(tput sgr0);

    echo -e "$CMD Checking out yarn.lock $RESET";
    git checkout -- yarn.lock;

    echo -e "$CMD Stashing changes $RESET";
    git stash;

    echo -e "$CMD Checking out origin/master $RESET";
    git checkout master;

    echo -e "$CMD Updating origin/master $RESET";
    git remote update && git rebase origin/master;

    echo -e "$CMD Pop stashed changes $RESET";
    git stash pop;

    echo -e "$CMD Detect NPM version with NVM$RESET";
    nvm use;

    echo -e "$CMD Build dependencies with Yarn$RESET";
    yarn install;

    echo -e "$CMD Build dependencies with Bower$RESET";
    bower install;

    echo -e "$CMD Rebuild node-sass with native extensions $RESET";
    npm rebuild node-sass;

    echo;
    echo -e "$(tput setaf 2) *** Switched to origin/master *** $RESET";
    git status;
}

#
# Defines transfer alias and provides easy command line file and folder sharing.
#
# Authors:
#   Remco Verhoef <remco@dutchcoders.io>
#

curl --version 2>&1 > /dev/null
if [ $? -ne 0 ]; then
  echo "Could not find curl."
  return 1
fi

transfer() { 
    # check arguments
    if [ $# -eq 0 ]; 
    then 
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # get temporarily filename, output is written to this file show progress can be showed
    tmpfile=$( mktemp -t transferXXX )
    
    # upload stdin or file
    file=$1

    if tty -s; 
    then 
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        
        if [ -d $file ];
        then
            # zip directory and transfer
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            # transfer file
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else 
        # transfer pipe
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
   
    # cat output link
    cat $tmpfile

    # cleanup
    rm -f $tmpfile
}

