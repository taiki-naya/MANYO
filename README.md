# Table Schema

### Model : Task
 * title : string
 * content : text
 * due_date : date
 * status : integer
 * priority : integer
 * user_id : bigint

### Model : User
 * name : string
 * email : string
 * password_digest : string
 * admin : boolean

### Model : Labelling
 * task_id : bigint
 * label_id : bigint

### Model : Label
 * name : string
 ---

 # Procedure of deploying to Heroku
  1. run "heroku login" to login heroku
  1. run "heroku create" to create an app
  1. run "rails assets:precompile RAILS_ENV=productioh" to compile before deploy
  1. run "git add & commit"
  1. install buildpacks
  1. run "git push heroku master" to deploy master branch
