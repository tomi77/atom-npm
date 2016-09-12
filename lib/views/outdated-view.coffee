npm = require '../npm'

module.exports = class OutdatedView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm outdated"'
    npm.getPackage(atom.project.getDirectories()[0].path).done (pkg) =>
      out = npm.outdated atom.project.getDirectories()[0].path, pkg

      if out.status
        atom.notifications.addError "npm outdated", detail: out.stdout.toString(), dismissable: yes
      else
        atom.notifications.addSuccess "npm outdated", detail: out.stdout.toString(), dismissable: yes

      return
