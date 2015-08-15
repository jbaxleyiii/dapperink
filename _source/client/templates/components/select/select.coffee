
class select extends Apollos.Forms.Select

  @register "select"

  template: ->
    return "Apollos.Forms.Select"


  onRendered: ->
    # library requires jquery
    _select = @.$("select")

    self = @
    placeholder = self.data().placeholder
    _select.select2({
      minimumResultsForSearch: Infinity
      placeholder: placeholder
    })

    super
