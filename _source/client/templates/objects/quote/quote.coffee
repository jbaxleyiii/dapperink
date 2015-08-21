

modifyPrice = (modifier, price, modifiers) ->

  price = Number(price)
  modifyValue = modifier.value

  if modifier.modifier and modifiers[modifier.modifier]
    if modifiers[modifier.modifier].value and not modifier.value
      modifyValue = modifiers[modifier.modifier].value

    else if modifiers[modifier.modifier].value and modifier.value
      # modifier.value = modifiers[modifier.modifier].value
      multiplier = modifiers[modifier.modifier].value


  if modifier.action is "add"
    price += modifyValue

  if modifier.action is "multiply"
    if modifier.range and modifier.highValue
      price = "#{Math.round(modifyValue * price * 100) / 100} - $#{Math.round(modifier.highValue * price * 100) / 100}"
    else
      price = modifyValue * price


  if modifier.action is "divide"
    price = price / modifyValue

  if modifier.action is "add-multiply"
    price = price + (multiplier * modifier.value)

  return price


class quote extends Apollos.Component
  @register "quote"

  vars: -> [
    productName: false
    modifiedBase: {}
    price: 0
    message: ""
    submitted: false
    ready: false
    selectedModifiers: {}

  ]

  placeholderText: ->
    return "1. #{@.data().quote.action}"

  subscriptions: -> [
    "products":
      args: [
        @.data().name
      ]
  ]

  products: ->
    products = Apollos.products.find().fetch()
    if products.length
      products = products.map( (opt) ->
        return {
          val: opt.name
          name: opt.label or opt.name
        }
      )
      return products

    return []

  events: -> [
    "change #products": @.setProduct
    "submit form": @.createInquiry
  ]


  onRendered: ->
    self = @
    serviceModifier = self.data().quote.modifier

    self.autorun ->
      product = self.productName.get()

      if not product
        return

      self.setPrice(0, product)


  setPrice: (totalPrice, product) ->

    self = @

    product = Apollos.products.findOne({name: product})

    # early return because no base price and message
    if product.message and not product.basePrice
      self.price.set false
      self.ready.set true
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
          self.ready.set true
          return

        # modifier number
        if typeof value is "number"
          totalPrice += value
          continue

        if value.modifier?.length
          for _modifier in value.modifier
            totalPrice = modifyPrice _modifier, totalPrice, modifiedBase

        # low range
        if value.low?.modifier
          for lowModifier in value.low.modifier
            totalPrice = modifyPrice lowModifier, totalPrice, modifiedBase
          multiplier = value.low.value

        # high range
        if value.high?.modifier and value.low?
          highPrice = modifyPrice value.high.modifier[0], totalPrice, modifiedBase
          highPriceMultiplier = value.high.value


    # multiply by modifiers
    if multiplier
      totalBasePrice = totalPrice
      totalPrice = Math.round(totalPrice * multiplier)

    # if top range
    if highPrice
      # highPrice = totalBasePrice * highPriceMultiplier
      totalPrice = "#{Math.round(Number(totalBasePrice))} - $#{Math.round(Number(highPrice))}"


    # final overiding calculation
    if product.modifiers.length is Object.keys(modifiedBase).length
      if product.modifier
        for _modifier in product.modifier
          totalPrice = modifyPrice _modifier, totalPrice, modifiedBase


    if typeof totalPrice isnt "string"
      totalPrice = Math.round(totalPrice)
    # render
    self.price.set totalPrice

  setProduct: (event) ->

    event.preventDefault()
    self = @

    oldProduct = self.productName.get()


    productName = event.target.value

    if productName is oldProduct
      return




    # self.$("[data-product]").removeClass("active")
    # self.$(event.currentTarget).addClass("active")

    allProducts = self.products()

    for _product in allProducts
      if _product.val isnt productName
        continue


      self.productName.set _product.val
      self.price.set 0
      self.selectedModifiers.set {}
      self.modifiedBase.set {}
  
      break


    # options =
    #   speed: 1000
    #   easing: 'easeOutCubic'
    #   offset: 250
    #
    #
    # smoothScroll.animateScroll(
    #   null, '#modifier', options
    # );

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

      # self.setPrice(0, self.productName.get())
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
      # self.setPrice(0, self.productName.get())
      return

  createInquiry: (event) ->

    self = @
    event.preventDefault()


    productName = self.productName.get()
    if not productName
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

      return

    price = self.price.get()
    price or= "call for pricing"

    route = Apollos.router.current()
    service = route.params?.service
    service or= window.location.pathname

    modal = Apollos.Component.getComponent("submitCard")
    modal = modal.renderComponent()

    data =
      type: service
      customer: Device
      responded: false
      viewed: false
      product:
        name: product.name
        label: product.label
      options: options
      price: price

    modal = Blaze.renderWithData(
      modal
      { data: data, isQuote: true}
      document.body
    )

    # Apollos.inquiries.insert({
    #   # email: email
    #   type: service
    #   customer: Device
    #   responded: false
    #   viewed: false
    #   product:
    #     name: product.name
    #     label: product.label
    #   options: options
    #   price: price
    # })
    #
    # self.submitted.set true
    #
    # setTimeout ->
    #   self.submitted.set false
    #   self.productName.set false
    #   options =
    #     speed: 1000
    #     easing: 'easeOutCubic'
    #     offset: 250
    #
    #   smoothScroll.animateScroll(
    #     null, '#products', options
    #   );
    #
    # , 5000

  insertDOMElement: (parent, node, before) ->
    if not node.id
      $(node).velocity("transition.slideLeftIn", { stagger: 250 })

    super
