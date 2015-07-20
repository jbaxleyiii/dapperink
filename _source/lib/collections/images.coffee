

# if Meteor.isClient
#
#   Apollos.ImageStore = new FS.Store.S3 "images"
#
#   Apollos.Images = new FS.Collection "images",
#     stores: [Apollos.ImageStore]
#
#   # should I move this to a template level subscribe?
#   Meteor.subscribe "images"
#
#
# if Meteor.isServer and Meteor.settings.s3Config
#   s3 = Meteor.settings.s3Config
#
#
#   Apollos.ImageStore = new (FS.Store.S3)("images",
#     # region: s3.region
#     accessKeyId: s3.accessKeyId
#     secretAccessKey: s3.secretAccessKey
#     bucket: s3.bucket
#     ACL: s3.ACL
#     folder: "uploads/"
#   )
#
#   Apollos.Images = new FS.Collection("images",
#     stores:
#       [
#         Apollos.ImageStore
#       ]
#   )
#
#   Meteor.publish "images", ->
#
#     Apollos.Images.find()
#
#
#   Apollos.Images.allow
#     insert: (user, file) ->
#       # Anyone can insert
#       true
#     remove: (user, file) ->
#       return file.metadata and file.metadata.user and file.metadata.user is user
#     update: ->
#       # Anyone can post
#       true
#     download: ->
#       true
