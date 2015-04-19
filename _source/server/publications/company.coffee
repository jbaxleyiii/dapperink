Meteor.publish "company", ->
  return Den.company.find()


Meteor.publish "services", ->
  return Den.services.find()


Meteor.publish "products", (service) ->
  return Den.products.find({service: service})
