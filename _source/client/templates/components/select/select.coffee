
class select extends BlazeComponent

  @register "select"

  template: ->
    return "select"


  onRendered: ->
    _select = @.templateInstance.$("select")

    _select.select2({
      minimumResultsForSearch: Infinity
    })


  events: ->
    return [

      "change select": (event) ->

        # console.log event.currentTarget.value

    ]

  onDestroyed: ->

    _select = @.templateInstance.$("select")

    _select.select2("destroy")
