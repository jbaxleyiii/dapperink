class footer extends BlazeComponent
  # Register a component so that it can be included in templates. It also
  # gives the component the name. This must be the name of the corresponding template
  @register "footer"

  template: ->
    return "footer"

  backgroundColor: ->

    color = @.data()?.backgroundColor
    return color or "tertiary"


  year: ->
    now = new Date()
    return now.getFullYear()

  # Prior to rendering the teamplate on the page
  onCreated: ->
    console.log "check out this great component"
