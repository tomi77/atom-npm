{$$, SelectListView} = require 'atom-space-pen-views'

module.exports = class BaseView extends SelectListView
  initialize: (pkgs) ->
    super
    data = @prepareData pkgs
    if data.length is 1
      @confirmed pkg: data[0].pkg
    else
      @setItems data
      @show()

  prepareData: (pkgs) -> throw new Error "prepareData is not implemented"

  getLabel: () -> throw new Error "getLabel is not implemented"

  parseData: (pkg) ->
    filter: pkg.name or pkg.wd
    label: @getLabel()
    pkg: pkg

  getFilterKey: () -> 'filter'

  show: () ->
    @panel ?= atom.workspace.addModalPanel item: @
    @panel.show()
    @focusFilterEditor()

  cancelled: () -> @hide()

  hide: () -> @panel?.destroy()

  viewForItem: ({pkg, label}) ->
    $$ ->
      @li =>
        @div label
        @div style: 'color: #989898', pkg.name or pkg.wd

  getNotificationTitle: (pkg) -> throw new Error "getNotificationTitle is not implemented"

  getResult: (pkg) -> throw new Error "getResult is not implemented"

  confirmed: ({pkg}) ->
    @cancel()

    out = @getResult pkg

    if out.status
      atom.notifications.addError @getNotificationTitle(pkg),
        detail: out.stdout.toString(),
        dismissable: yes
    else
      atom.notifications.addSuccess @getNotificationTitle(pkg),
        detail: out.stdout.toString(),
        dismissable: yes
