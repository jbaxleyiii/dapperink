

modifyPrice = (modifier, price) ->

  if modifier.action is "add"
    price += modifier.value

  return price



class quote extends Apollos.Component
  @register "quote"

  vars: -> [
    product: ""

    modifiedBase: ""
    price: 0
    message: ""
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
    return

  onRendered: ->
    self = @
    serviceModifier = self.data().quote.modifier

    self.autorun ->


      totalPrice = 0
      product = self.product.get()

      if not product
        self.price.set totalPrice
        return


      # early return because not base price and message
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

          # modifer number
          if typeof value is "number"
            totalPrice += value
            continue

          # low range
          if value.low?.modifier
            totalPrice = modifyPrice value.low.modifier, totalPrice
            multiplier = value.low.value

          # high range
          if value.high?.modifier and value.low?
            highPrice = modifyPrice value.high.modifier, totalPrice
            highPriceMultiplier = value.high.value


      # multiply by modifiers
      if multiplier
        totalBasePrice = totalPrice
        totalPrice = totalPrice * multiplier

      # if top range
      if highPrice and highPriceMultiplier and totalBasePrice
        highPrice = totalBasePrice * highPriceMultiplier
        totalPrice = "#{totalPrice} - #{highPrice}"

      # render
      self.price.set totalPrice




  events: ->

    return [

      "click [data-product]": (event) ->

        self = @

        productName = event.currentTarget.dataset.product

        allProducts = @.products()

        if allProducts
          for _product in allProducts
            if _product.name is productName
              @.product.set _product
              break



      "change select": (event) ->

        self = @

        serviceModifier = self.data().quote.modifier

        modifierName = event.currentTarget.dataset.name
        value = event.currentTarget.value
        product = self.product.get()

        if not value or not product or not modifierName
          return

        for modifier in product.modifiers

          ###

            Early exit if the modifier isnt the select you modified

          ###
          if modifier.name isnt modifierName
            continue

          ###

            Service level modifier

            This select triggered is the one that handles the total
            valuation of the quote. The selected value is store to be used
            once I figure out what to do with it

          ###
          if modifier.name is serviceModifier
            for option in modifier.options

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

            break


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

            self.modifiedBase.set(modifiedPrice)
            break

    ]



  # events: ->
  #
  #   return [
  #
  #     "click [data-upload]": (event) ->
  #       event.preventDefault()
  #
  #       if event.target.dataset?.upload
  #         @.find("##{event.target.dataset.upload}").click()
  #
  #       return
  #
  #     "change #upload": (event, template) ->
  #       FS.Utility.eachFile(event, (file) ->
  #
  #         Apollos.Images.insert(file, (err, fileObj) ->
  #
  #           if err
  #             debug err
  #
  #           debug fileObj
  #
  #         )
  #
  #       )
  #   ]
