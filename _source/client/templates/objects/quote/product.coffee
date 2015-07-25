
class productModifier extends Apollos.Component

  @register "productModifier"

  vars: -> [

    productName: false

  ]

  onCreated: ->
    self = @
    self.productName.set self.data().name

  onRendered: ->
    self = @

    self.autorun ->
      self.productName.set self.data().name

  update: (val, modifier) ->

    @.parent().adjustPrice val, modifier



  modifiers: ->

    self = @

    productName = self.productName.get()
    product = Apollos.products.findOne({name: productName})

    if not product
      return

    modifiers = product.modifiers
    modifiers or= []
    
    index = 1
    for modifier in modifiers
      modifier.count = index + 1
      index++

    return modifiers
