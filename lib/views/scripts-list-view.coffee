{$$, SelectListView} = require 'atom-space-pen-views'
keys = require 'lodash/keys'
{execSync} = require 'child_process'
Promise = require 'promise'
npm = require '../npm'

module.exports =
  class ScriptsListView extends SelectListView
    initialize: () ->
      super
      pkgs = atom.project.getDirectories().map (dir) -> npm.getPackage dir.path
      Promise.all(pkgs).done (pkgs) =>
        data = pkgs.reduce (data, pkg) =>
          data.concat @parseData pkg
        , []
        @setItems data
        @show()

    parseData: (pkg) -> keys(pkg.scripts or {}).map (script) ->
      script: script
      pkg: pkg

    getFilterKey: () -> 'script'

    show: () ->
      @panel ?= atom.workspace.addModalPanel item: @
      @panel.show()
      @focusFilterEditor()

    cancelled: () -> @hide()

    hide: () -> @panel?.destroy()

    viewForItem: ({script, pkg}) ->
      $$ ->
        @li =>
          @div script
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
