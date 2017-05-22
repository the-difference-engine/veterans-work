# Veterans Work
### Example workflow:
1. I start at my local repo's master branch and cut a new feature

    `git checkout -b <branch_name>`
2. I write some hot code.

    `x += 1 #whoa`
3. I add all and commit.

    `git add --all`

    `git commit -m "descriptive and short af message"`
4. I push my commits to my forked github repo.

    `git push <user_name> <branch_name>`
5. I go to the organization repo **or** my forked copy on github.com and trigger a pull request with the message waiting for me on the page.

6. I add my trello board story URL and a description of my work to the PR comments description field.

7. I post in the slack channel with @here prbeg <link to pull request>

8. I await a thumbs up emoji and rebeg if no one responds.

9. I merge my PR into master.

10. I discuss qa deployment with my leads and team.

### Deployment Guide

As discussed in our first meeting, we will follow a strict protocol for pull requests and deployments. Overall, Veterans Work will be **deployed** in three environments:

As you develop, you will push from your fork and create pull requests on github.com as such:

**my_fork** --> **organization master** --> **qa** --> **demo** --> **production**

From qa and on, Veterans Work will automatically build and deploy to heroku as app instances on three different URL's when merged into these respective branches:

qa: http://qa-veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/qa-veterans-work/activity)

demo: http://demo-veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/demo-veterans-work/activity)

production: http://veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/veterans-work/activity)


Login details should be obtained in person for access to the build log and never shared on slack or this repo.

**The reason for doing it this way is to always deploy from our one source of truth, the organization's repo, not our own.**


