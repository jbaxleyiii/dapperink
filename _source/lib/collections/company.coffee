
Den.company = new Mongo.Collection "company"

# TODO: Make this secure
Den.company.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true

service = new SimpleSchema
  name:
    type: String
    optional: false
  label:
    type: String
    optional: true
  template:
    type: String
    optional: true
  url:
    type: [String]
    optional: true


company = new SimpleSchema
  name:
    type: String
    optional: true
  updatedBy:
    type: String
    optional: true
  description:
    type: String
    optional: true
  social:
    type: [Den.schemas.social]
    optional: true
  location:
    type: Den.schemas.location
    optional: true
  hours:
    type: String
    optional: true
  contactEmail:
    type: String
    optional: true
    regEx: Den.regex.email
  adminEmail:
    type: String
    optional: true
    regEx: Den.regex.email
  services:
    type: [service]
    optional: true



Den.company.attachSchema company
