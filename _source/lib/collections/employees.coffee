Apollos.employees = new Mongo.Collection "employees"

# TODO: Make this secure
Apollos.employees.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true


endeavors = Apollos.generateSchema
  name:
    type: String
    optional: true
  link:
    type: String
    optional: true
    regEx: Apollos.regex.url

employees = Apollos.generateSchema
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
    type: [Apollos.schemas.social]
    optional: true
  photo:
    type: String
    optional: true
    regEx: Apollos.regex.url
  profile:
    type: String
    optional: true
    regEx: Apollos.regex.url
  email:
    type: String
    optional: true
    regEx: Apollos.regex.email
  endeavors:
    type: [endeavors]
    optional: true

Apollos.employees.attachSchema employees
