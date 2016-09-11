npm = require '../npm'

module.exports = class UpdateView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm update"'
    npm.getPackage().done (pkg) =>
      out = npm.update atom.project.getDirectories()[0].path, pkg
      @show out.toString()
      return

  show: (txt) ->
    atom.notifications.addSuccess "npm update", detail: txt, dismissable: yes
    return
