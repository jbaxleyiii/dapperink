Meteor.publish "company", ->
  return Den.company.find()


Meteor.publish "services", ->
  return Den.services.find()


Meteor.publish "products", (service) ->

  products = Den.products.find({service: service})

  return products
