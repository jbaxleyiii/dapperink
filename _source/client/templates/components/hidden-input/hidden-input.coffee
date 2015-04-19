
class hiddenInput extends BlazeComponent

  @register "hiddenInput"

  template: ->
    return "hiddenInput"


  onCreated: ->

    self = @

    args = self.templateInstance.data
    args or= {}

    self.dynamicValue = new ReactiveVar(args.name)
    self.editing = new ReactiveVar(false)

    if not args.collection
      debug "You must specify a collection to update this value"
      return

    if not args.field
      debug "You must specify a field to update this value"
      return


    self.subscribe args.collection


  onRendered: ->

    self = @

    args = self.templateInstance.data
    args or= {}

    self.autorun ->

      entry = args.entry
      if not entry
        fields = {}
        fields[args.field] = 1

        dynamicValue = Den[args.collection].findOne({}, {
          fields: fields
        })

      dynamicValue or= {}
      self.dynamicValue.set dynamicValue[args.field]

      template = self.templateInstance
      dynamicContainer = template.find("[data-editable]")

      dynamicContainer.textContent = self.dynamicValue.get()


  dynamicValue: ->

    return @.dynamicValue.get()

  events: ->

    [

      "click [data-edit]": (event) ->

        editing = @.editing.get()


        template = @.templateInstance
        editable = template.find("[data-editable]")

        if not editing
          editable.setAttribute("contentEditable", true)
        else
          editable.setAttribute("contentEditable", false)

        @.editing.set(!editing)


      "blur [data-editable], keyup [data-editable]": (event) ->

        template = @.templateInstance
        value = event.target.textContent

        collection = template.data.collection
        if not collection
          debug "You must specify a collection to update this value"
          return

        field = template.data.field
        if not field
          debug "You must specify a field to update this value"
          return

        # set value
        update = {}
        update[field] = value

        entry = template.data.entry
        if not entry
          entryLookup = Den[collection].findOne()

          entry = entryLookup?._id

          if not entry
            Den[collection].insert update

          else
            Den[collection].update(entry, {
              $set: update
            })

    ]
