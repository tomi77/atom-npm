{$$, SelectListView} = require 'atom-space-pen-views'

module.exports = class OutdatedListView extends SelectListView
  initialize: (@pkg, list) ->
    super
    @setItems list.map @parseData
    @show()

  parseData: (el) ->
    label: "Update #{el[1]}@#{el[2]} to #{el[3]}"
    path: el[0]
    name: el[1]
    current: el[2]
    wanted: el[3]
    latest: el[4]

  getFilterKey: () -> 'name'

  show: () ->
    @panel ?= atom.workspace.addModalPanel item: @
    @panel.show()
    @focusFilterEditor()

  cancelled: () -> @hide()

  hide: () -> @panel?.destroy()

  viewForItem: ({label}) ->
    $$ ->
      @li =>
        @div label

  getNotificationTitle: () -> "npm update @ #{@pkg.name or @pkg.wd}"

  confirmed: ({name, wanted}) ->
    @cancel()

    info = atom.notifications.addInfo @getNotificationTitle(),
      detail: "Updating #{name} ..."
      dismissable: yes

    @pkg.once 'exit', (status, stdout, stderr) =>
      info.dismiss()

      if status
        atom.notifications.addError @getNotificationTitle(),
          description: "Some error occurred"
          detail: stderr
          dismissable: yes
      else
        atom.notifications.addSuccess @getNotificationTitle(),
          description: "Successfully update #{name}"

    @pkg.update name
