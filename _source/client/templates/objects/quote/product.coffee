
class productModifier extends Apollos.Component

  @register "productModifier"

  vars: -> [

    productName: false
    modifiers: []

  ]

  onCreated: ->
    self = @
    self.productName.set self.data().name

  onRendered: ->
    self = @

    self.autorun ->
      self.productName.set self.data().name

    self.autorun ->
      productName = self.productName.get()

      if productName
        product = Apollos.products.findOne({name: productName})
      else
        product = Apollos.products.find().fetch()[0]

      if not product
        return

      modifiers = product.modifiers
      modifiers or= []

      index = 1
      for modifier in modifiers
        if index is 1 and productName
          modifier.active = true
        else
          modifier.acitve = false
        modifier.count = index + 1
        index++

      self.modifiers.set modifiers



  update: (val, modifier) ->
    self = @
    self.parent().adjustPrice val, modifier

    existingModList = self.modifiers.get()

    # this is really gross
    next = false
    for mod in existingModList

      if mod.name is modifier.name
        next = true
        continue

      if next
        mod.active = true
        break

    self.modifiers.set existingModList
