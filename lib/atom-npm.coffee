{CompositeDisposable} = require 'atom'

ScriptsListView = require './views/scripts-list-view'
OutdatedView = require './views/outdated-view'
InstallView = require './views/install-view'
UpdateView = require './views/update-view'

module.exports =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-npm:run': () -> new ScriptsListView()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-npm:outdated': () -> new OutdatedView()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-npm:install': () -> new InstallView()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-npm:update': () -> new UpdateView()

    return

  deactivate: () ->
    @subscriptions.dispose()
    return
