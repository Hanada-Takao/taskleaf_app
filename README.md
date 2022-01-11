
| tasks       |        | User            |        |
| ----------- | ------ | --------------- | ------ |
| id          |        | id              |        |
| user_id     |        | name            | string |
| name        | string | email           | string |
| description | text   | password_digest | string | 

Herokuへのデプロイ手順

$ rails assets:precompile RAILS_ENV=production

$ heroku login

$ git remote -v

$ git status

$ git add .

$ git commit -m "任意のコメント"

$ git push heroku 作業ブランチ名:master

$ heroku run rails db:migrate

Gemのバージョン　2.2.21

