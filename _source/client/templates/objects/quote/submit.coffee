

class submitCard extends Apollos.Component

  @register "submitCard"


  vars: -> [
    submitted: false
  ]

  events: -> [
    "click .close": @.destroy
    "click button": @.submit
  ]

  onCreated: ->

    self = @
    data = self.data().data

    self.query = data

    self.isQuote = data.isQuote or false
    $("html").addClass("modal--opened")


  submit: (event) ->
    self = @
    children = {}
    for child in self.children()
      data = child.data()
      if not data.name
        continue

      children[data.name] = child

    email = self.find("input[name=Email]").value.toLowerCase()
    name = self.find("input[name=Name]").value.toLowerCase()
    description = self.find("textarea[name=Description]").value.toLowerCase()

    if not name
      children["Name"].setStatus true
      return

    if not Apollos.validate.isEmail email
      children["Email"].setStatus true
      return


    quote = self.query

    quote.email = email
    quote.name = name
    quote.description = description

    Apollos.inquiries.insert(quote)

    self.submitted.set true


  destroy: (event) ->

    self = @
    window.testView = @._internals.templateInstance.view
    Blaze.remove @._internals.templateInstance.view
    $("html").removeClass("modal--opened")
