
class Apollos.Forms.TextArea extends Apollos.Forms.Input
  @register "Apollos.Forms.TextArea"
  template: -> "Apollos.Forms.TextArea"


  events: -> [

    "focus textarea": @.focused


    "blur textarea": @.blurred

    # can this be a change event?
    # "focus textarea, keyup textarea, blur textarea": @.changed


    "focus textarea, keyup textarea": @.active

  ]

  setValue: (value) ->

    value or= ""
    @.value.set value
    @.find("textarea").value = value


class select extends Apollos.Forms.Select

  @register "select"

  template: ->
    return "Apollos.Forms.Select"

  vars: -> super.concat [
    previousOptions: []
  ]

  onCreated: ->
    self = @
    items = self.data().items
    self.previousOptions.set items


  onRendered: ->

    # library requires jquery
    _select = @.$("select")

    self = @

    placeholder = self.data().placeholder
    _select.select2({
      minimumResultsForSearch: Infinity
      placeholder: placeholder
    })


    self.autorun ->
      currentData = self.currentData()
      oldItems = self.previousOptions.get()

      isSame = true
      for item, index in oldItems
        if item.name isnt currentData.items[index]?.name
          isSame = false

      if not isSame
        self.previousOptions.set(currentData.items)

        data = currentData.items.map( (x) ->
          return {
            id: x.val
            text: x.name
          }
        )

        _select.empty()
        _select.select2({
          minimumResultsForSearch: Infinity
          placeholder: placeholder
          data: data
        })
        # , 75


    super
