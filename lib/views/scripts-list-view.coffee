{$$, SelectListView} = require 'atom-space-pen-views'
keys = require 'lodash/keys'
{makeEnv} = require 'npm/lib/utils/lifecycle'
{execSync} = require 'child_process'
npm = require '../npm'

module.exports =
  class ScriptsListView extends SelectListView
    initialize: () ->
      super
      npm.getPackage(atom.project.getDirectories()[0].path).done (pkg) =>
        @pkg = pkg
        @data = pkg.scripts or {}
        @setItems @parseData @data
        @show()

    parseData: (scripts) -> keys(scripts).map (script, content) ->
      label: "Run #{script}"
      script: script

    getFilterKey: () -> 'name'

    show: () ->
      @panel ?= atom.workspace.addModalPanel(item: this)
      @panel.show()
      @focusFilterEditor()

    cancelled: () -> @hide()

    hide: () -> @panel?.destroy()

    viewForItem: ({label}) ->
      $$ ->
        @li =>
          @span label

    confirmed: ({script}) ->
      @cancel()

      out = npm.run atom.project.getDirectories()[0].path, @pkg, script

      if out.status
        atom.notifications.addError "npm run #{script}", detail: out.stdout.toString(), dismissable: yes
      else
        atom.notifications.addSuccess "npm run #{script}", detail: out.stdout.toString(), dismissable: yes
