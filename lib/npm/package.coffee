{BufferedProcess} = require 'atom'
EventEmitter = require 'events'

{makeEnv} = require 'npm/lib/utils/lifecycle'
extend = require 'lodash/extend'

module.exports = class Package extends EventEmitter
  constructor: (@wd, pkg, @npm) ->
    extend @, pkg

    env = makeEnv pkg
    @conf = cwd: @wd, env: env, shell: yes

    if process.platform is 'win32' then @conf.windowsVerbatimArguments = true

    return

  exec: (script) ->
    stdoutBuffer = []
    stderrBuffer = []

    new BufferedProcess
      command: "npm"
      args: script
      options: @conf
      stdout: (output) ->
        stdoutBuffer = stdoutBuffer.concat output
        return
      stderr: (output) ->
        stderrBuffer = stderrBuffer.concat output
        return
      exit: (code) =>
        @emit 'exit', code, stdoutBuffer.join('\n'), stderrBuffer.join('\n')
        return

    return

  run: (script) -> @exec ['run', script]

  outdated: () -> @exec ['outdated']

  install: (name) -> @exec if name? then ['install', name] else ['install']

  update: (name) -> @exec if name? then ['update', name] else ['update']
