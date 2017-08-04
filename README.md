# Veterans Work

### What We Use

* App Framework - [Rails](http://rubyonrails.org/)
* Database - [Postgres](https://www.postgresql.org/)
* Backend Testing - [Rspec-Rails](http://rspec.info/documentation/3.6/rspec-rails/)
* Feature Testing - [Capybara](https://github.com/teamcapybara/capybara)
* Test Coverage - [Simplecov](https://github.com/colszowka/simplecov#simplecov----)
* Continuous Integration (CI) - [Travis](https://travis-ci.org/)
* Frontend Framework - [React](https://facebook.github.io/react/)
* Development Mailbox - [Mailcatcher](https://mailcatcher.me/)
* Node Dependency Managment - [Yarn](https://yarnpkg.com/lang/en/)
* Project Management - [Trello](https://trello.com/b/xNkJUl4n/veterans-work)
* Fun Times - [Booze](https://en.wikipedia.org/wiki/Alcohol#Alcoholic_beverages)
* App Health Monitoring - [Sentry](https://sentry.io/tdengine/)
* App Hosting - [Heroku](https://dashboard.heroku.com/pipelines/59144ee6-73bf-4f9a-91ea-43da97e9108f)
* [Make](http://www.math.tau.ac.il/~danha/courses/software1/make-intro.html)

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

10. Once merged I await my changes to be deployed to the [qa environment](http://qa-veterans-work.herokuapp.com/).

### Working with Mailers in Development Mode
To interact with the app's mailers, you need to run **Mailcatcher** in tandem with Veterans Work. To do this, make sure you've installed it by using `gem install mailcatcher` and then open a separate terminal window and activate Mailcatcher with: `mailcatcher`.

This will spin up an inbound mailbox app that you can interact with by opening `localhost:1080` in your browser.

### Deployment Guide

As discussed in our first meeting, we will follow a strict protocol for pull requests and deployments. Overall, Veterans Work will be **deployed** in three environments:

As you develop, you will push from your fork and create pull requests on github.com as such:

**my_fork** --> organization master auto deploys to **qa** --> **demo** --> **production**

From qa and on, Veterans Work will automatically build and deploy to heroku as app instances on three different URL's when merged into these respective branches:

development: http://qa-veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/qa-veterans-work/activity)

staging: http://demo-veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/demo-veterans-work/activity)

production: http://veterans-work.herokuapp.com/ | [build activity](https://dashboard.heroku.com/apps/veterans-work/activity)

[project pipeline](https://dashboard.heroku.com/pipelines/59144ee6-73bf-4f9a-91ea-43da97e9108f)

Once code is merged into our organization master branch, we propel it through the heroku pipeline using the heroku UI.

>Note: No need to open PR's from one branch to another on github.

**Login details should be obtained in person for access to the build log and never shared on slack or this repo.**

