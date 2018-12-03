# This scripts will replace the author info on all commit!!!
# even on commits made by others. 
# So only use this script on a repository when you are sure 
# all commits within it are made by you.
# !! Dont forget to change usernameOnGithub
# And GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL within the filter-branch command


# Possible improvements:
# Catch command line arguments when script is called with reponames
# Loop through multiple reponames instead of calling the functino multiple times
# Use the variables newAuthor.... within the git filter command
# 


cdAndfilterbranch(){
    repoName=${1}.git
    usernameOnGithub="ADogan"
    
    # This resulted in:  fatal: empty ident name (for <>) not allowed, leaving it as this
    # newAuthorUsername="Ali Dogan"
    # newAuthorMail="alidogan.just.for.commitsx@gmail.com"

    git clone --bare https://github.com/$usernameOnGithub/$repoName
    cd $repoName
    echo $newAuthorUsername
    echo $newAuthorMail
    git filter-branch --env-filter '
        export GIT_AUTHOR_NAME="Ali Dogan"
        export GIT_AUTHOR_EMAIL="alidogan.just.for.commitsx@gmail.com"
    ' --tag-name-filter cat -- --branches --tags
    
    git push --force --tags origin 'refs/heads/*'

    # Change the directory to be able to delete it and if you want to run the function
    # on a different repository
    cd ..

    # Delete temporary folder
    rm -R $repoName
}

cdAndfilterbranch projecteuler.net-solutions
# cdAndfilterbranch repo2
# cdAndfilterbranch repo3
# cdAndfilterbranch etc