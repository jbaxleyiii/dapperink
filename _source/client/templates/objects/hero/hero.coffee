class Hero extends Apollos.Component
  @register "Hero"


  subscriptions: -> [
    "company"
    "services"
  ]

  vars: -> [
    img: "screen2.b&w.jpg"
  ]

  serviceList: ->

    rawList = [
      {
        name: "screen prints"
        url: "/screen-printing"
        service: "screen-printing"
      }
      {
        name: "letterpress"
        url: "/letterpress"
        service: "letterpress"
      }
      {
        name: "posters & signs"
        url: "/custom-printing"
        service: "custom-printing"
      }
    ]
    list = []

    active = @.data()?.active
    active = encodeURI(active)

    for entry, index in rawList

      if entry.url is "/#{active}" and index > 0
        list.unshift entry
      else
        list.push entry



    return list

  onCreated: ->

    self = @
    active = self.data()?.active

    switch active
      when "screen-printing"
        self.img.set("dapperphoto2.jpg")
      when "letterpress"
        self.img.set("dapperphoto3.jpg")
      when "custom-printing"
        self.img.set("screen1.b&w.jpg")



  company: ->
    if @.subscriptionsReady()
      return Apollos.company.findOne()


  isActive: (route) ->

    active = @.data()?.active

    active = encodeURI(active)
    if route is "/#{active}"
      return "active"

    return



class HeroImage extends Apollos.Component
  @register "HeroImage"

  insertDOMElement: (parent, node, before) ->
    if not node.id
      $(node).velocity("transition.slideLeftIn", { stagger: 250 })

    super


class HeroAlt extends Hero
  @register "HeroAlt"

  onCreated: ->

    self = @
    active = self.data()?.active

    switch active
      when "screen-printing"
        self.img.set("screen2.b&w.jpg")
      when "letterpress"
        self.img.set("letterpress.b&w.jpg")
      when "custom-printing"
        self.img.set("screen1.b&w.jpg")

class HeroImageAlt extends HeroImage
  @register "HeroImageAlt"
