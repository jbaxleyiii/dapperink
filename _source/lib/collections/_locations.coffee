
location = new SimpleSchema

  street:
    type: String
    optional: true
  street2:
    type: String
    optional: true
  city:
    type: String
    optional: true
  state:
    type: String
    regEx: Den.regex.state
  zip:
    type: String
    regEx: Den.regex.zip
    optional: true
  phone:
    type: String
    optional: true
    regEx: Den.regex.phone
  email:
    type: String
    optional: true
    regEx: Den.regex.email
  geometry:
    type: Den.schemas.geoJSON
    optional: true
  updatedDate:
    type: Date
    autoValue: ->
      return new Date

Den.schemas.locations = location
