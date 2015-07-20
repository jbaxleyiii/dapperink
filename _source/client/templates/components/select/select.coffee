
class select extends Apollos.Forms.Select

  @register "select"

  template: ->
    return "Apollos.Forms.Select"


  onRendered: ->
    _select = @.$("select")

    _select.select2({
      minimumResultsForSearch: Infinity
    })

    super


  onDestroyed: ->

    _select = @.$("select")

    if _select and _select.select2
      _select.select2("destroy")

    super
