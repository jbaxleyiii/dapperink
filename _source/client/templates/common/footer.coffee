class Footer extends Apollos.Component
  @register "Footer"


  year: ->
    now = new Date()
    return now.getFullYear()

  company: ->
    company = Apollos.company.findOne()

    return company
