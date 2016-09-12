npm = require '../npm'

module.exports = class UpdateView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm update"'
    npm.getPackage().done (pkg) =>
      out = npm.update atom.project.getDirectories()[0].path, pkg

      if out.status
        atom.notifications.addError "npm update", detail: out.stdout.toString(), dismissable: yes
      else
        atom.notifications.addSuccess "npm update", detail: out.stdout.toString(), dismissable: yes

      return
