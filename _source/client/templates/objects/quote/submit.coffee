

class submitCard extends Apollos.Component

  @register "submitCard"

  events: -> [
    "click .icon": @.destroy
  ]

  destroy: (event) ->
    self = @

    event?.preventDefault()
    Blaze.remove @._internals.templateInstance.view
