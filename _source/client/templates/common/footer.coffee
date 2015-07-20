class Footer extends Apollos.Component
  @register "Footer"


  year: ->
    now = new Date()
    return now.getFullYear()
