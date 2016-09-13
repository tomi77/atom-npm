keys = require 'lodash/keys'
BaseView = require './base-view'

module.exports = class OutdatedView extends BaseView
  prepareData: (pkgs) ->
    pkgs.filter (pkg) -> keys(pkg).length > 0
    .map (pkg) => @parseData pkg

  getLabel: () -> 'outdated'

  getNotificationTitle: (pkg) -> "npm outdated @ #{pkg.name or pkg.wd}"

  getResult: (pkg) -> pkg.outdated()
