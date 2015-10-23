

class service extends Apollos.Component
  @register "service"

  onRendered: ->

    active = @.data().serviceName
    $("html").addClass(active)


    # $("body")
    #   .velocity({padding: "0"})

  onDestroyed: ->
    active = @.data().serviceName
    $("html").removeClass(active)


    # $("body")
    #   .velocity({padding: "40px"})


  service: ->
    active = @.data().serviceName
    return Apollos.services.findOne({name: active})


  # insertDOMElement: (parent, node, before) ->
  #
  #   console.log "inserting new page..."
  #   # if not node.id
  #   #   $(node).velocity("transition.slideLeftIn", { stagger: 250 })
  #
  #   super
