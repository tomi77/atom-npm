npm = require '../npm'

module.exports = class InstallView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm install"'
    npm.getPackage().done (pkg) =>
      out = npm.install atom.project.getDirectories()[0].path, pkg
      @show out.toString()
      return

  show: (txt) ->
    atom.notifications.addSuccess "npm install", detail: txt, dismissable: yes
    return
