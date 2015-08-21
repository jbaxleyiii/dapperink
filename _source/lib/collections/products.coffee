Apollos.products = new Mongo.Collection "products"

# TODO: Make this secure
Apollos.products.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true


modifier = Apollos.generateSchema("modifier",
  {
    action:
      type: String
      optional: false
    value:
      type: Number
      optional: true
      decimal: true
    modifier:
      type: String
      optional: true
    range:
      type: Boolean
      optional: true
      defaultValue: false
    highValue:
      type: Number
      optional: true
      decimal: true
  }, true
)



range = Apollos.generateSchema("range",
  {
    value:
      type: Number
      optional: true
      decimal: true
    modifier:
      type: [modifier]
      optional: true
  }, true
)


options = Apollos.generateSchema("options",
  {
    name:
      type: String
      optional: false
    label:
      type: String
      optional: true
    message:
      type: String
      optional: true
    low:
      type: range
      optional: true
    high:
      type: range
      optional: true
    basePrice:
      type: Number
      optional: true
      decimal: true
    value:
      type: Number
      optional: true
      decimal: true
    modifier:
      type: [modifier]
      optional: true
  }, true
)



modifiers = Apollos.generateSchema("modifiers"
  {
    name:
      type: String
      optional: false
    label:
      type: String
      optional: true
    description:
      type: String
      optional: true
    required:
      type: Boolean
      optional: true
    type:
      type: String
      optional: false
    input:
      type: Object
      blackbox: true
      optional: true
    range:
      type: Boolean
      optional: true
    options:
      type: [options]
      optional: true
    modifier:
      type: [modifier]
      optional: true
  }, true
)




products = Apollos.generateSchema
  name:
    type: String
    optional: false
  order:
    type: Number
    optional: false
  label:
    type: String
    optional: true
  service:
    type: String
    optional: true
  icon:
    type: String
    optional: true
  description:
    type: String
    optional: true
  images:
    type: Object
    optional: true
    blackbox: true
  basePrice:
    type: Number
    optional: true
    decimal: true
  message:
    type: String
    optional: true
  modifiers:
    type: [modifiers]
    optional: true
  modifier:
    type: [modifier]
    optional: true



Apollos.products.attachSchema products
