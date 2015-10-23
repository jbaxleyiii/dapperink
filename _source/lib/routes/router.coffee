
Apollos.Router.route("/", {
  action: (params, queryParams) ->

    Apollos.router.go("/screen-printing")
})


Apollos.Router.route("/terms/:term", {

  action: (params) ->

    GAnalytics.pageview("/terms/#{params.term}");
    Apollos.Layout.render("page-layout", {
      template: "screen-printing"
    })

    if params.term is "privacy-policy"
      tmpl = "privacy"

    else if params.term is "terms-of-use"
      tmpl = "terms"

    else
      return

    if Meteor.isClient
      modal = Apollos.Component.getComponent("termsModal")
      modal = modal.renderComponent()

      modal = Blaze.renderWithData(
        modal
        { template: tmpl}
        document.body
      )

})

Apollos.Router.route("/:service", {
  action: (params, queryParams) ->
    GAnalytics.pageview("/#{params.service}");
    Apollos.Layout.render("page-layout", {
      template: params.service
    })

  name: "service"
})
