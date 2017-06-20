#############
# FUNCTIONS #
#############


# ember_mark_tests() {
#     search_phrase="$1";
#     put_command "Marking tests containing the phrase $(highlight "'${search_phrase}'")"
#     test_files=(grep -i -l -R "$search_phrase" ./tests);
#     file_count=(echo $test_files | wc -l | sed -e 's/^ *//');

#     put_note "Found $(highlight "$file_count") files:"
#     echo -e "$(dim "${test_files}")";

#     exit;

#     xargs sed -i '' -e "s/^describe('/describe('RUN /g" -e "s/Integration:/RUN Integration:/g"
# }


# Ember
ember_version() {
    # no validation yet... don't screw up!
    version=$1

    # green [command] prefix to make our output stand out
    # among other command output
    CMD=$(echo -e "\n$(tput setaf 4)[INFO]$(tput bold)");
    RESET=$(tput sgr0);

    echo -e "$CMD Uninstalling current version of ember-cli $RESET";
    npm uninstall ember-cli;

    echo -e "$CMD Cleaning npm cache $RESET";
    npm cache clean;

    echo -e "$CMD Cleaning bower cache $RESET";
    bower cache clean;

    echo -e "$CMD Cleaning yarn cache $RESET";
    yarn cache clean;

    echo -e "$CMD Install ember-cli version $version (global)$RESET";
    npm install -g ember-cli@${version};

    # TODO: prompt before doing this
    echo -e "$CMD Nuke assets (node_modules, bower_components, dist, tmp)$RESET";
    rm -rf ./node_modules ./bower_components ./dist ./tmp;

    echo -e "$CMD Install ember-cli at version $version (package)$RESET";
    npm install --save-dev ember-cli@${version} --save-exact;

    echo -e "$CMD Detect NPM version with NVM$RESET";
    nvm use;

    echo -e "$CMD Build dependencies with Yarn$RESET";
    yarn install;

    echo -e "$CMD Build dependencies with Bower$RESET";
    bower install;

    echo -e "$CMD Rebuild node-sass with native extensions $RESET";
    npm rebuild node-sass;
    
    echo;
    echo -e "$(tput setaf 2)[SUCCESS] $(tput setaf 7)*** EMBER $version INSTALLED *** $RESET";
    ember -v;
}