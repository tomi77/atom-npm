npm = require '../npm'

module.exports = class UpdateView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm update"'
    npm.getPackage(atom.project.getDirectories()[0].path).done (pkg) =>
      out = pkg.update()

      if out.status
        atom.notifications.addError "npm update", detail: out.stdout.toString(), dismissable: yes
      else
        atom.notifications.addSuccess "npm update", detail: out.stdout.toString(), dismissable: yes

      return
