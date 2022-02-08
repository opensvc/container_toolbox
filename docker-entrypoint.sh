#!/bin/sh

if [ "$1" = 'git-pull' ]; then
    if [ -z ${GIT_SYNC_REPO:+x} ]; then
	    echo "GIT_SYNC_REPO is unset. Skipping.";
    else
	    echo "Git Puller '$GIT_SYNC_REPO'";
            GIT_BRANCH=${GIT_BRANCH:-main}
	    GIT_SYNC_ROOT=${GIT_SYNC_ROOT:-/data}
	    GIT_SYNC_DEST=${GIT_SYNC_DEST:-repo}
	    GIT_OPTS=${GIT_OPTS}
	    GIT_USER_EMAIL=${GIT_USER_EMAIL:-git-puller@opensvc.com}
	    GIT_USER_NAME=${GIT_USER_NAME:-OpenSVC Git Puller}
	    if [ ! -d ${GIT_SYNC_ROOT} ]; then
		    mkdir -p ${GIT_SYNC_ROOT}
	    fi
	    cd ${GIT_SYNC_ROOT} && {
		    [ ! -d ${GIT_SYNC_DEST} ] && {
		            echo "Cloning repo with command <git clone ${GIT_OPTS} ${GIT_SYNC_REPO} ${GIT_SYNC_DEST}>"
		            git clone ${GIT_OPTS} ${GIT_SYNC_REPO} ${GIT_SYNC_DEST} || exit 1
		    }
	            cd ${GIT_SYNC_DEST}
		    git config pull.ff only
                    git config user.email "${GIT_USER_EMAIL}"
                    git config user.name "${GIT_USER_NAME}"
		    echo "Pulling ${GIT_SYNC_REPO}"
		    git pull || exit 1
		    echo "Checking out branch ${GIT_BRANCH}"
	            git checkout ${GIT_BRANCH} || exit 1
	    }
    fi
    exit 0
fi

exec "$@"
