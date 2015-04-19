

modifyPrice = (modifier, price) ->

  if modifier.action is "add"
    price += modifier.value

  return price



class quote extends BlazeComponent
  # Register a component so that it can be included in templates. It also
  # gives the component the name. This must be the name of the corresponding template
  @register "quote"

  template: ->
    return "quote"

  onCreated: ->
    self = @

    self.vars or= {}

    self.vars.products = new ReactiveVar()
    self.vars.product = new ReactiveVar()

    self.vars.modifiedBase = new ReactiveVar({})
    self.vars.price = new ReactiveVar(0)
    self.vars.message = new ReactiveVar()

    service = self.data().name

    self.subscribe "products", service, (err) ->
      if err
        return

      self.vars.products.set Den.products.find().fetch()


  onRendered: ->

    self = @
    serviceModifier = self.data().quote.modifier

    self.autorun ->

      totalPrice = 0
      product = self.vars.product.get()

      console.log product

      if not product
        self.vars.price.set totalPrice
        return


      # early return because not base price and message
      if product.message and not product.basePrice
        self.vars.price.set false
        self.vars.message.set product.message
        return


      basePrice = product.basePrice
      totalPrice += basePrice

      highPrice = false
      highPriceMultiplier = false

      multiplier = false
      modifiedBase = self.vars.modifiedBase.get()

      if modifiedBase
        for modifier, value of modifiedBase

          # early return for message
          if value.message
            self.vars.price.set false
            self.vars.message.set value.message
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
      self.vars.price.set totalPrice



  price: ->
    return @.vars.price.get()


  products: ->
    return @.vars.products.get()


  product: ->

    return @.vars.product.get()

  message: ->
    return @.vars.message.get()



  events: ->

    return [

      "click [data-product]": (event) ->

        self = @

        productName = event.currentTarget.dataset.product

        allProducts = @.vars.products.get()

        if allProducts
          for _product in allProducts
            if _product.name is productName
              @.vars.product.set _product
              break



      "change select": (event) ->

        self = @

        serviceModifier = self.data().quote.modifier

        modifierName = event.currentTarget.dataset.name
        value = event.currentTarget.value
        product = self.vars.product.get()

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
                self.vars.hasRange.set true

              modifiedPrice = self.vars.modifiedBase.get()

              if option.basePrice
                modifiedPrice[modifierName] = option.basePrice

              else
                modifiedPrice[modifierName] = option

              self.vars.modifiedBase.set(modifiedPrice)

            break


          ###

            Base level modifier

            This select triggered modifies the base price so it is stored
            in a function that recalcultes the overall price

          ###
          for option in modifier.options
            if option.name isnt value
              continue

            modifiedPrice = self.vars.modifiedBase.get()

            if option.basePrice
              modifiedPrice[modifierName] = option.basePrice

            self.vars.modifiedBase.set(modifiedPrice)
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
  #         Den.Images.insert(file, (err, fileObj) ->
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
