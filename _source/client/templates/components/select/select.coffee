
class select extends Apollos.Forms.Select

  @register "select"

  template: ->
    return "Apollos.Forms.Select"


  onRendered: ->
    # library requires jquery
    _select = @.$("select")

    _select.select2({
      minimumResultsForSearch: Infinity
    })

    super
