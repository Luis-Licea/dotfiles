# Steps to perform before and after pushing

- `git pull --rebase origin master`
  - Check for conflicts and unintended code changes
- Check commit messages for typos (languagetool-node)
- Test code works:
  - Run tests (JavaScript, Python, C++)
  - Run linters
  - Run program
  - Run relevant Jenkins, GitHub, or GitLab pipelines
- `git pull --rebase origin master` if changes occurred during testing
- `git push origin my_branch`
- Verify pipelines pass
- Proof read all modified files before creating a PR or review
