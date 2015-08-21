

class termsModal extends Apollos.Component

  @register "termsModal"


  events: -> [
    "click .close": @.destroy
  ]

  templateName: ->

    return @.data().template

  onCreated: ->

    self = @
    $("html").addClass("modal--opened")


  destroy: (event) ->

    self = @
    Blaze.remove @._internals.templateInstance.view
    $("html").removeClass("modal--opened")
