class services extends BlazeComponent

  @register "services"

  template: ->
    return Template.services

  onCreated: ->

    console.log "creating services"
    self = @

    @.subscribe "services"

  service: ->
    if @.templateInstance?.data?.name
      name = @.templateInstance.data.name
      service =  Den.services.findOne({name: name})
      return service

    return
