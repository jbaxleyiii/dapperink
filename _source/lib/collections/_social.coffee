
social = new SimpleSchema

  name:
    type: String
    optional: false
  link:
    type: String
    optional: false
    regEx: Den.regex.url
  updatedDate:
    type: Date
    autoValue: ->
      return new Date

Den.schemas.social = social
