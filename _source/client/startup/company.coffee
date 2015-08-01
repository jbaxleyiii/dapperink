Meteor.startup ->

  Meteor.subscribe "company"
  Meteor.subscribe "services"

  smoothScroll.init({
    "updateURL": false
  })

  
