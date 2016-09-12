npm = require '../npm'

module.exports = class InstallView
  constructor: () ->
    atom.notifications.addInfo 'Run "npm install"'
    npm.getPackage(atom.project.getDirectories()[0].path).done (pkg) =>
      out = npm.install atom.project.getDirectories()[0].path, pkg

      if out.status
        atom.notifications.addError "npm install", detail: out.stdout.toString(), dismissable: yes
      else
        atom.notifications.addSuccess "npm install", detail: out.stdout.toString(), dismissable: yes

      return
