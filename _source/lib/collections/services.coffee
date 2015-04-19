Den.services = new Mongo.Collection "services"

# TODO: Make this secure
Den.services.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true

quote = new SimpleSchema
  name:
    type: String
    optional: true
  label:
    type: String
    optional: true
  action:
    type: String
    optional: true
  modifier:
    type: String
    optional: true


services = new SimpleSchema
  name:
    type: String
    optional: true
  label:
    type: String
    optional: true
  description:
    type: String
    optional: true
  images:
    type: Object
    optional: true
    blackbox: true
  colors:
    type: Object
    optional: true
    blackbox: true
  quote:
    type: quote
    optional: true
  employees:
    type: [String]
    optional: true
  ad:
    type: Object
    optional: true
    blackbox: true

Den.services.attachSchema services
