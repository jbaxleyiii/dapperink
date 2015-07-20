Meteor.publish "company", ->
  return Apollos.company.find()


Meteor.publish "services", ->
  return Apollos.services.find()


Meteor.publish "products", (service) ->

  products = Apollos.products.find({service: service})

  return products
