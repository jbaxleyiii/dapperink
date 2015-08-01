
Apollos.company = new Mongo.Collection "company"

# # TODO: Make this secure
# Apollos.company.allow
#   insert: (userId, doc) ->
#     return true
#   update: (userId, doc) ->
#     return true
#   remove: (userId, doc) ->
#     return true
#
# service = Apollos.generateSchema("service",
#   {
#     name:
#       type: String
#       optional: false
#     label:
#       type: String
#       optional: true
#     template:
#       type: String
#       optional: true
#     url:
#       type: [String]
#       optional: true
#   }, true
# )
#
#
# company = Apollos.generateSchema
#   name:
#     type: String
#     optional: true
#   updatedBy:
#     type: String
#     optional: true
#   description:
#     type: String
#     optional: true
#   social:
#     type: [Object]
#     optional: true
#   location:
#     type: Apollos.schemas.location
#     optional: true
#   hours:
#     type: String
#     optional: true
#   contactEmail:
#     type: String
#     optional: true
#     regEx: Apollos.regex.email
#   adminEmail:
#     type: String
#     optional: true
#     regEx: Apollos.regex.email
#   services:
#     type: [service]
#     optional: true
#
#
#
# Apollos.company.attachSchema company
