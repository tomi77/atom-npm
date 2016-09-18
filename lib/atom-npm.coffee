{CompositeDisposable} = require 'atom'

RunView = require './views/run-view'
OutdatedView = require './views/outdated-view'
InstallDependenciesView = require './views/install-dependencies-view'
UpdateDependenciesView = require './views/update-dependencies-view'
Promise = require 'promise'
npm = require './npm'

module.exports =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-npm:run': () => @getPackages().done (pkgs) -> new RunView pkgs
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-npm:outdated': () => @getPackages().done (pkgs) -> new OutdatedView pkgs
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-npm:install-dependencies': () => @getPackages().done (pkgs) -> new InstallDependenciesView pkgs
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-npm:update-dependencies': () => @getPackages().done (pkgs) -> new UpdateDependenciesView pkgs

    return

  deactivate: () ->
    @subscriptions.dispose()
    return

  getPackages: () -> Promise.all atom.project.getDirectories().map (dir) -> npm.getPackage dir.path
