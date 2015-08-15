
Template.Dropzone.helpers({

  hasFile: -> Session.get("hasFile")
  submitting: -> Session.get("submitting")

})


Template.Dropzone.events({
  "dropped #dropzone": (event, template) ->
    Apollos.fs.parse(event, (file) ->

      newFile = Apollos.fs.file(file)
      Template.Dropzone.file = newFile
      Session.set("hasFile", true)
    )

})

class ad extends Apollos.Component
  @register "ad"

  vars: -> [
    service: null
    file: null
  ]

  onRendered: ->
    Session.set("submitting", false)
    Session.set("hasFile", false)


  events: -> [

    "submit form": @.submitForm

  ]

  submitForm: (event) ->

    self = @
    event.preventDefault()

    children = {}
    for child in self.children()
      data = child.data()
      if not data.name
        continue

      children[data.name] = child

    email = self.find("input[name=email]").value.toLowerCase()

    if not Apollos.validate.isEmail email
      children["email"].setStatus true
      return

    file = Template.Dropzone.file

    if not file
      children["email"].setStatus "Please upload a file", true
      return

    ###

      we have a valid email and a file. So now we upload the file and create
      an entry in the inquiries table with the following schema

      {
        email: email
        file: file
      }

    ###

    Apollos.fs["uploads"].insert(file, (err, fileObj) ->

      if err
        throw new Apollos.Error err
        return
      route = Apollos.router.current()
      service = route.params?.service

      service or= window.location.pathname

      Apollos.inquiries.insert({
        email: email
        file: file._id
        type: service
        customer: Device
        responded: false
        viewed: false
      })

      Session.set("submitting", true)
      Session.set("hasFile", false)

      setTimeout ->
        Session.set("submitting", false)
        Apollos.fs.uploadQueue.reset()
      , 5000

    )



  onCreated: ->

    service = @.data().active

    @.service.set(service)


  mockData: ->

    service = @.service.get().replace(" ", "-")

    mocks = {}

    mocks["screen-printing"] =
      image: "storefront.b&w.jpg"
      title: "...and also really great designers"
      copy: "Whether we’re creating a brand identity or a single tee shirt graphic, we make a meaningful designs that fulfill our clients’ needs and leave a lasting impression."
      cta:
        type: "button"
        copy: "Let's talk!"
        link: "#team"

    mocks["letterpress"] = mocks["screen-printing"]
    mocks["custom-printing"] = mocks["screen-printing"]
    # mocks["letterpress"] =
    #   image: "screen2.b&w.jpg"
    #   title: "We are printers"
    #   copy: "Have a great idea but need help fleshing it out? We have a phenomenal team of designers and we would love to help!"
    #   cta:
    #     type: "button"
    #     copy: "Meet our printers"
    #     link: "#team"
    #
    # mocks["custom-printing"] =
    #   image: "screen1.b&w.jpg"
    #   title: "Custom Design"
    #   copy: "We are great at all kinds of print. Yes, including long form. Have an awesome banner you want printed? We can help."
    #   cta:
    #     type: "upload"
    #     copy: "Send Artwork"
    #     link: "#"


    return mocks[service]


  # removeDOMElement: (parent, node) ->
  #
  #   width = $(window).width()
  #   height = $(window).height()
  #
  #   # fade out background
  #   $(node).velocity "fadeOut",
  #     duration: 250
  #     complete: (elements) ->
  #       $(node).remove()
