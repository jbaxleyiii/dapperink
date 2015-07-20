class Hero extends Apollos.Component
  @register "Hero"


  subscriptions: -> [
    "company"
    "services"
  ]

  vars: -> [
    img: "screen2.b&w.jpg"
  ]


  onCreated: ->

    self = @
    active = self.data()?.active

    switch active
      when "screen-printing"
        self.img.set("screen2.b&w.jpg")
      when "letterpress"
        self.img.set("letterpress.b&w.jpg")
      when "custom-printing"
        self.img.set("storefront.b&w.jpg")



  company: ->
    if @.subscriptionsReady()
      return Apollos.company.findOne()


  isActive: (route) ->

    active = @.data()?.active

    active = encodeURI(active)
    if route is "/#{active}"
      return "active"

    return
