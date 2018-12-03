
cloneCdFilterAndPush(){
    repoName=$1
    GithubUsername="ADogan"

    git clone --bare https://github.com/$GithubUsername/$repoName
    cd $repoName
    git filter-branch --env-filter '
        export GIT_AUTHOR_NAME="Ali Dogan"
        export GIT_AUTHOR_EMAIL="alidogan.just.for.commits@gmail.com"
    ' --tag-name-filter cat -- --branches --tags
    
    git push --force --tags origin 'refs/heads/*'
    cd ..

    # Delete temporary folder
    # rm -R $repoName
}

# usage
cloneCdFilterAndPush projecteuler.net-solutions.git
cloneCdFilterAndPush web2_jqm.git
cloneCdFilterAndPush ADogan.github.io.git
cloneCdFilterAndPush CodingChallenges.git
cloneCdFilterAndPush AngyLoad.git
cloneCdFilterAndPush iTunesGraphs.git
cloneCdFilterAndPush sublime-2-user-packages.git
cloneCdFilterAndPush Memory.git
cloneCdFilterAndPush iepro_1.git