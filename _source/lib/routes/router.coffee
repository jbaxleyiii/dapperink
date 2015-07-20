
Apollos.Router.route("/", {
  action: (params, queryParams) ->

    Apollos.router.go("/screen-printing")
})



Apollos.Router.route("/:service", {
  action: (params, queryParams) ->

    Apollos.Layout.render("page-layout", {
      template: params.service
    })

  name: "service"
})
