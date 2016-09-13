{$$, SelectListView} = require 'atom-space-pen-views'
keys = require 'lodash/keys'

module.exports =
  class RunView extends SelectListView
    initialize: (pkgs) ->
      super
      data = pkgs.reduce (data, pkg) =>
        data.concat @parseData pkg
      , []
      @setItems data
      @show()

    parseData: (pkg) -> keys(pkg.scripts or {}).map (script) ->
      filter: "#{script} #{pkg.name or pkg.wd}"
      label: script
      script: script
      pkg: pkg

    getFilterKey: () -> 'filter'

    show: () ->
      @panel ?= atom.workspace.addModalPanel item: @
      @panel.show()
      @focusFilterEditor()

    cancelled: () -> @hide()

    hide: () -> @panel?.destroy()

    viewForItem: ({label, pkg}) ->
      $$ ->
        @li =>
          @div label
          @div style: 'color: #989898', pkg.name or pkg.wd

    confirmed: ({script, pkg}) ->
      @cancel()

      out = pkg.run script

      if out.status
        atom.notifications.addError "npm run #{script} (#{pkg.name or pkg.wd})",
          detail: out.stdout.toString(),
          dismissable: yes
      else
        atom.notifications.addSuccess "npm run #{script} (#{pkg.name or pkg.wd})",
          detail: out.stdout.toString(),
          dismissable: yes
