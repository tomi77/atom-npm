npm = require '../npm'

module.exports = class OutdatedView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm outdated"'
    npm.getPackage().done (pkg) =>
      out = npm.outdated atom.project.getDirectories()[0].path, pkg
      @show out.toString()
      return

  show: (txt) ->
    atom.notifications.addSuccess "npm outdated", detail: txt, dismissable: yes
    return
