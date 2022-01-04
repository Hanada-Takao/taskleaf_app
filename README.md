# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
Herokuへのデプロイ手順
$ rails assets:precompile RAILS_ENV=production

$ heroku login

$ git remote -v

$ git status

$ git add .

$ git commit -m "任意のコメント"

$ git push heroku 作業ブランチ名:master

$ heroku run rails db:migrate