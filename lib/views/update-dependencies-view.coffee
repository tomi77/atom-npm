keys = require 'lodash/keys'
BaseView = require './base-view'

module.exports = class UpdateDependenciesView extends BaseView
  prepareData: (pkgs) ->
    pkgs.filter (pkg) -> keys(pkg).length > 0
    .map (pkg) => @parseData pkg

  getLabel: () -> 'update'

  getNotificationTitle: (pkg) -> "npm update @ #{pkg.name or pkg.wd}"

  getResult: (pkg) -> pkg.update()

  parseResult: (pkg) ->
    atom.notifications.addSuccess @getNotificationTitle(pkg),
      detail: "Update finished successfully"
