

class service extends Apollos.Component
  @register "service"



  onCreated: ->

    console.log "creating services"



  service: ->
    active = @.data().serviceName
    return Apollos.services.findOne({name: active})
