keys = require 'lodash/keys'
Promise = require 'promise'
BaseView = require './base-view'
OutdatedListView = require './outdated-list-view'
{getNpm} = require '../npm'

module.exports = class OutdatedView extends BaseView
  prepareData: (pkgs) ->
    pkgs.filter (pkg) -> keys(pkg).length > 0
    .map (pkg) => @parseData pkg

  getLabel: () -> 'outdated'

  getNotificationTitle: (pkg) -> "npm outdated @ #{pkg.name or pkg.wd}"

  getResult: (pkg) -> pkg.outdated()

  parseResult: (pkg, list) ->
    if list.length is 0
      atom.notifications.addInfo @getNotificationTitle(),
        detail: "Everything is up-to-date"
    else
      new OutdatedListView pkg, list
