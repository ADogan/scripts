#####################################################
##### WARNING - THIS SCRIPT REWRITES GIT HISTORY ####
##### Only run when you know what you are doing! ####
##### I will take no responsibility for any      ####
##### problems this script might cause!          ####
#####################################################
# This script will replace the author and committer info on commits!
# Dont forget to change usernameOnGithub, Emails to check for
# and NEW_NAME + NEW_EMAIL

# Immediate push back to remote repo is disable by default, uncomment to activate.

# Possible improvements to this script:
# catch parameter to push for a dry run
# catch parameter to push to remote repo 
# catch parameter to delete temporary clone

usernameOnGithub=""

filterBranch(){
    git filter-branch --env-filter '
        EMAIL1=""
        EMAIL2=""
        EMAIL3=""
        NEW_NAME=""
        NEW_EMAIL=""

        if [ "$GIT_COMMITTER_EMAIL" = "$EMAIL1" ] || [ "$GIT_COMMITTER_EMAIL" = "$EMAIL2" ] || [ "$GIT_COMMITTER_EMAIL" = "$EMAIL3" ]
        then
            export GIT_COMMITTER_NAME="$NEW_NAME"
            export GIT_COMMITTER_EMAIL="$NEW_EMAIL"
        fi

        if [ "$GIT_AUTHOR_EMAIL" = "$EMAIL1" ] || [ "$GIT_AUTHOR_EMAIL" = "$EMAIL2" ] || [ "$GIT_AUTHOR_EMAIL" = "$EMAIL3" ]
        then
            export GIT_AUTHOR_NAME="$NEW_NAME"
            export GIT_AUTHOR_EMAIL="$NEW_EMAIL"
        fi
    ' --tag-name-filter cat -- --branches --tags
}

cloneAndfilterbranch(){
    for i in "$@"; do
        echo "$i"
        repoName=$i.git
        
        git clone --bare https://github.com/$usernameOnGithub/$repoName
        cd $repoName
        echo $newAuthorUsername
        echo $newAuthorMail

        filterBranch

        # uncomment the following line you if you want to push it to the remote repo while running the script
        # git push --force --tags origin 'refs/heads/*'

        # Change the directory to one level up,
        # Reason: to be able to delete the temporary clone and also if you want to run the function for the next repository
        cd ..

        # Delete temporary folder
        # rm -R $repoName
    done
}

cloneAndfilterbranch repo1 repo2 repo3