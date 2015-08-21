Meteor.publish "company", ->
  return Apollos.company.find()


Meteor.publish "services", ->
  return Apollos.services.find()


Meteor.publish "products", (service) ->

  products = Apollos.products.find({service: service}, {sort: order: 1})

  return products
