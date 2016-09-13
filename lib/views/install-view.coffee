keys = require 'lodash/keys'
BaseView = require './base-view'

module.exports = class InstallView extends BaseView
  prepareData: (pkgs) ->
    pkgs.filter (pkg) -> keys(pkg).length > 0
    .map (pkg) => @parseData pkg

  getLabel: () -> 'install'

  getNotificationTitle: (pkg) -> "npm install @ #{pkg.name or pkg.wd}"

  getResult: (pkg) -> pkg.install()
