# Table Schema

### Model : Task
 * title : string
 * content : text
 * due_date : date
 * status : integer
 * priority : integer


 ---

 # Procedure of deploying to Heroku
  1. run "heroku login" to login heroku
  1. run "heroku create" to create an app
  1. run "rails assets:precompile RAILS_ENV=productioh" to compile before deploy
  1. run "git add & commit"
  1. install buildpacks
  1. run "git push heroku master" to deploy master branch
