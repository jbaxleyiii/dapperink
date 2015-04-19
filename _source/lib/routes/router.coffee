
Router.configure
  progressSpinner: false
  layoutTemplate: "layout"

  waitOn: ->
    Meteor.subscribe "company"
    Meteor.subscribe "services"


Meteor.startup ->

  services = Den.company.findOne({}, {
    fields:
      services: 1
  })

  services = services.services

  if not services
    return

  setRoute = (url, template, name, register) ->
    if register
      Router.route url, ->
        return @.render(
          template
          data:
            serviceName: name
        )
      , name: name

      return

    Router.route url, ->
      return @.render(
        template
        data:
          serviceName: name
      )



  for service in services when service.template
    nameSet = false
    for url in service.url
      if not nameSet
        setRoute(url, service.template, service.name, true)
        nameSet = true
        continue

      setRoute(url, service.template, service.name, false)

      continue


if Meteor.isClient
  Transitioner.default
    in: "transition.fadeIn"
    out: "transition.fadeOut"
