

class service extends Apollos.Component
  @register "service"


  service: ->
    active = @.data().serviceName
    return Apollos.services.findOne({name: active})
