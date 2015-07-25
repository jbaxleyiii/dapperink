Apollos.services = new Mongo.Collection "services"

# TODO: Make this secure
Apollos.services.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true

quote = Apollos.generateSchema("quote",
  {
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

  }, true
)


services = Apollos.generateSchema
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

Apollos.services.attachSchema services
