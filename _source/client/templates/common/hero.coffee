class hero extends BlazeComponent
  # Register a component so that it can be included in templates. It also
  # gives the component the name. This must be the name of the corresponding template
  @register "hero"

  template: ->
    return "hero"

  onCreated: ->

    self = @

    self.vars or= {}
    self.vars.company = new ReactiveVar()
    self.vars.services = new ReactiveVar()

    self.subscribe "company", (err) ->
      if err
        return
      self.vars.company.set Den.company.findOne()


    self.subscribe "services", (err) ->
      if err
        return
      self.vars.services.set Den.services.findOne()



  company: ->
    return @.vars.company.get()

  service: ->
    links = []

    company = @.vars.company.get()

    console.log company.services

    links = company.services

    return links


  backgroundColor: ->
    # service = @.vars.services.get()

    color = @.templateInstance.data?.backgroundColor
    return color or "secondary"

  isActive: (route) ->

    lastSegment = Router.current().route.getName()

    if lastSegment is route
      return "active"

    return

  # year: ->
  #   now = new Date()
  #   return now.getFullYear()
