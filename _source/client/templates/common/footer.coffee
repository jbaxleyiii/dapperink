class Footer extends Apollos.Component
  @register "Footer"

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
