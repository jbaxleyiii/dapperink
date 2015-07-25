

modifyPrice = (modifier, price, modifiers) ->

  price = Number(price)


  if modifier.modifier and modifiers[modifier.modifier]
    if modifiers[modifier.modifier].value
      modifier.value = modifiers[modifier.modifier].value

  if modifier.action is "add"
    price += modifier.value

  if modifier.action is "multiply"
    price = modifier.value * price

  if modifier.action is "divide"
    price = price / modifier.value

  return price.toFixed(2)


class quote extends Apollos.Component
  @register "quote"

  vars: -> [
    productName: false
    modifiedBase: {}
    price: 0
    message: ""
    submitted: false
    selectedModifiers: {}
  ]

  subscriptions: -> [
    "products":
      args: [
        @.data().name
      ]
  ]

  products: ->
    products = Apollos.products.find().fetch()
    if products.length
      return products
    return []

  events: -> [
    "click [data-product]": @.setProduct
    "submit form": @.createInquiry
  ]

  onRendered: ->
    self = @
    serviceModifier = self.data().quote.modifier

    self.autorun ->
      totalPrice = 0
      product = self.productName.get()

      if not product
        self.price.set totalPrice
        return

      self.setPrice(totalPrice, product)

  setPrice: (totalPrice, product) ->

    self = @

    product = Apollos.products.findOne({name: product})

    # early return because no base price and message
    if product.message and not product.basePrice
      self.price.set false
      self.message.set product.message
      return

    basePrice = product.basePrice
    totalPrice += basePrice

    highPrice = false
    highPriceMultiplier = false

    multiplier = false
    modifiedBase = self.modifiedBase.get()

    if modifiedBase
      for modifier, value of modifiedBase
        # early return for message
        if value.message
          self.price.set false
          self.message.set value.message
          return

        # modifier number
        if typeof value is "number"
          totalPrice += value
          continue

        if value.modifier?.length
          for _modifier in value.modifier
            totalPrice = modifyPrice _modifier, totalPrice

        # low range
        if value.low?.modifier
          for lowModifier in value.low.modifier
            totalPrice = modifyPrice lowModifier, totalPrice
          multiplier = value.low.value

        # high range
        if value.high?.modifier and value.low?
          highPrice = modifyPrice value.high.modifier[0], totalPrice
          highPriceMultiplier = value.high.value


    # multiply by modifiers
    if multiplier
      totalBasePrice = totalPrice
      totalPrice = (totalPrice * multiplier).toFixed(2)

    # if top range
    if highPrice
      # highPrice = totalBasePrice * highPriceMultiplier
      totalPrice = "#{totalBasePrice.toFixed(2)} - #{highPrice.toFixed(2)}"



    # final overiding calculation
    if product.modifiers.length is Object.keys(modifiedBase).length
      if product.modifier
        for _modifier in product.modifier
          totalPrice = modifyPrice _modifier, totalPrice, modifiedBase

    # render
    self.price.set totalPrice

  setProduct: (event) ->

    event.preventDefault()
    self = @

    productName = event.currentTarget.dataset.product

    allProducts = self.products()

    for _product in allProducts
      if _product.name isnt productName
        continue

      self.productName.set _product.name
      break

    return

  adjustPrice: (value, modifier) ->

    self = @
    serviceModifier = self.data().quote.modifier

    product = self.productName.get()
    product = Apollos.products.findOne({name: product})
    modifierName = modifier.name

    if not value or not product
      return

    # store the modifiers for inquiry
    storedModifiers = self.selectedModifiers.get()

    storedModifiers[modifier.name] or= modifier
    storedModifiers[modifier.name].value = value

    self.selectedModifiers.set storedModifiers

    # ###
    #
    #   Service level modifier
    #
    #   This select triggered is the one that handles the total
    #   valuation of the quote. The selected value is store to be used
    #   once I figure out what to do with it
    #
    # ###
    if modifier.name is serviceModifier

      ###

        Special case for optionless modifiers

      ###
      options = modifier.options
      options or= []

      if not options.length and modifier.modifier[0]
        options.push({
          name: "#{value}"
          low:
            modifier: [modifier.modifier[0]]
            value: value
        })

      for option in options

        if option.name isnt value
          continue

        if option.range
          self.hasRange.set true

        modifiedPrice = self.modifiedBase.get()

        if option.basePrice
          modifiedPrice[modifierName] = option.basePrice
        else
          modifiedPrice[modifierName] = option

        self.modifiedBase.set(modifiedPrice)

      self.setPrice(0, self.productName.get())
      return


    ###

      Base level modifier

      This select triggered modifies the base price so it is stored
      in a function that recalcultes the overall price

    ###
    for option in modifier.options

      if option.name isnt value
        continue

      modifiedPrice = self.modifiedBase.get()

      if option.basePrice
        modifiedPrice[modifierName] = option.basePrice
      else
        modifiedPrice[modifierName] = option


      self.modifiedBase.set(modifiedPrice)
      self.setPrice(0, self.productName.get())
      return

  createInquiry: (event) ->


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

    # Tracker.nonreactive ->
    #   quote = self.data().quote

    productName = self.productName.get()
    if not productName
      children["email"].setStatus "Please choose a product", true
      setTimeout ->
        children["email"].setStatus false
      , 1500
      return

    storedOptions = self.selectedModifiers.get()

    options = []
    for name, opts of storedOptions
      options.push({
        name: opts.name
        label: opts.label
        value: opts.value
      })

    product = Apollos.products.findOne({
      name: productName
    })

    product.modifiers or = []
    if options.length isnt product.modifiers.length
      for modifier in product.modifiers
        names = []
        for choosenOptions in options
          names.push choosenOptions.name

        if names.indexOf(modifier.name) is -1
          children["email"].setStatus(
            "Please #{modifier.label.toLowerCase()}"
            true
          )
          setTimeout ->
            children["email"].setStatus false
          , 1500
          break

      return

    price = self.price.get()
    price or= "call for pricing"

    route = Apollos.router.current()
    service = route.params?.service
    service or= window.location.pathname

    Apollos.inquiries.insert({
      email: email
      type: service
      customer: Device
      responded: false
      viewed: false
      product:
        name: product.name
        label: product.label
      options: options
      price: price
    })

    self.submitted.set true

    setTimeout ->
      self.submitted.set false
      self.productName.set false
    , 5000
