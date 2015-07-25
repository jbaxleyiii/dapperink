

class modifier extends Apollos.Component
  @register "modifier"


  vars: -> [
    value: false
  ]

  events: -> [
    "change select": @.update
  ]

  update: (event) ->
    val = event.target.value


    @.parent().update val, @.modifier()

  modifier: ->
    return @.data().modifier

  modifiers: ->

    options = @.modifier().options

    options = options.map( (opt) ->

      return {
        val: opt.name
        name: opt.name
      }
    )

    return options
