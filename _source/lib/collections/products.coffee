Den.products = new Mongo.Collection "products"

# TODO: Make this secure
Den.products.allow
  insert: (userId, doc) ->
    return true
  update: (userId, doc) ->
    return true
  remove: (userId, doc) ->
    return true


modifier = new SimpleSchema
  action:
    type: String
    optional: false
  value:
    type: Number
    optional: false
    decimal: true


range = new SimpleSchema

  value:
    type: Number
    optional: false
    decimal: true
  modifier:
    type: [modifier]
    optional: true


options = new SimpleSchema

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


modifiers = new SimpleSchema
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
  range:
    type: Boolean
    optional: true
  options:
    type: [options]
    optional: true
  modifer:
    type: [modifier]
    optional: true



products = new SimpleSchema
  name:
    type: String
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



Den.products.attachSchema products
