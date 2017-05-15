# github-releaser
Console-based tool to automatically form releases based on your pull requests.

Usage:

  `docker run -it nmingazov/github-releaser:0.1 -o <owner> -r <repo> -a --only-pulls --use-commit-body`

Based on the [github-changes](https://github.com/lalitkapoor/github-changes).

Currently it doesn't release things to github for you, but, nevertheless, prints all PR that are not in release but would be there!
