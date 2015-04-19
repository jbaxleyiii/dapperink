Den.employees = new Mongo.Collection "employees"

# TODO: Make this secure
Den.employees.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true


endeavors = new SimpleSchema
  name:
    type: String
    optional: true
  link:
    type: String
    optional: true
    regEx: Den.regex.url

employees = new SimpleSchema
  firstName:
    type: String
    optional: false
  lastName:
    type: String
    optional: false
  nickName:
    type: String
    optional: true
  title:
    type: String
    optional: true
  social:
    type: [Den.schemas.social]
    optional: true
  photo:
    type: String
    optional: true
    regEx: Den.regex.url
  profile:
    type: String
    optional: true
    regEx: Den.regex.url
  email:
    type: String
    optional: true
    regEx: Den.regex.email
  endeavors:
    type: [endeavors]
    optional: true

Den.employees.attachSchema employees
