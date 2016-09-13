{CompositeDisposable} = require 'atom'

RunView = require './views/run-view'
OutdatedView = require './views/outdated-view'
InstallView = require './views/install-view'
UpdateView = require './views/update-view'
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
      'atom-npm:install': () => @getPackages().done (pkgs) -> new InstallView pkgs
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-npm:update': () => @getPackages().done (pkgs) -> new UpdateView pkgs

    return

  deactivate: () ->
    @subscriptions.dispose()
    return

  getPackages: () -> Promise.all atom.project.getDirectories().map (dir) -> npm.getPackage dir.path
