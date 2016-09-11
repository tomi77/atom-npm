{$$, SelectListView} = require 'atom-space-pen-views'
keys = require 'lodash/keys'
{makeEnv} = require 'npm/lib/utils/lifecycle'
{execSync} = require 'child_process'
npm = require '../npm'

module.exports =
  class ScriptsListView extends SelectListView
    initialize: (@pkg) ->
      super
      @data = pkg.scripts or {}
      @setItems @parseData @data
      @focusFilterEditor()

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

      atom.notifications.addSuccess "npm run #{script}", detail: out.toString(), dismissable: yes
