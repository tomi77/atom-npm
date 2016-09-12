{spawnSync} = require 'child_process'

{makeEnv} = require 'npm/lib/utils/lifecycle'
extend = require 'lodash/extend'

module.exports = class Package
  constructor: (@wd, pkg) ->
    extend @, pkg

    env = makeEnv pkg
    @conf = cwd: @wd, env: env, shell: yes

    if process.platform is 'win32' then @conf.windowsVerbatimArguments = true

  exec: (script) -> spawnSync "npm #{script}", @conf

  run: (script) -> @exec "run #{script}"

  outdated: () -> @exec 'outdated'

  install: () -> @exec 'install'

  update: () -> @exec 'update'
