#!/bin/bash

# Use current directory as repository path
REPO_PATH=$(pwd)

# Ask for branch name
echo "What is the name of the branch?"
read -r BRANCH

# Navigate to repository
cd "$REPO_PATH" || exit 1

# Add all changes
git add .

# Check if there are changes to commit
if git diff-staged --quiet; then
    echo "No changes to commit"
else
    # Ask for commit message
    echo "What is your commit?"
    read -r COMMIT_MESSAGE
    
    # Use default message if empty
    if [ -z "$COMMIT_MESSAGE" ]; then
        TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
        COMMIT_MESSAGE="Auto-commit: $TIMESTAMP"
    fi
    
    # Commit with the message
    git commit -m "$COMMIT_MESSAGE"
    
    # Push to remote
    git push origin "$BRANCH"
    
    echo "Changes pushed successfully!"
fi
