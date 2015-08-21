class Footer extends Apollos.Component
  @register "Footer"


  events: -> [
    "click [data-terms]": @.showTerms
  ]

  showTerms: (event) ->

    event.preventDefault()

    tmpl = event.target.dataset.terms

    modal = Apollos.Component.getComponent("termsModal")
    modal = modal.renderComponent()

    modal = Blaze.renderWithData(
      modal
      { template: tmpl}
      document.body
    )



  scImage: ->
    active = @.data().active

    image = "yellowfSCooter"

    switch active
      when "letterpress"
        image = "cyanSCooter"
      when "custom-printing"
        image = "magentaSCooter"

    return image



  year: ->
    now = new Date()
    return now.getFullYear()

  company: ->
    company = Apollos.company.findOne()

    return company
