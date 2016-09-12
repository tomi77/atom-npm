path = require 'path'
{spawnSync} = require 'child_process'

npm = require 'npm/lib/npm'
npmconf = require 'npm/lib/config/core'
{makeEnv} = require 'npm/lib/utils/lifecycle'
Promise = require 'promise'
readJson = require 'read-package-json'
nopt = require 'nopt'
extend = require 'lodash/extend'

configDefs = npmconf.defs
shorthands = configDefs.shorthands
types = configDefs.types
conf = nopt types, shorthands

getNpm = () ->
  new Promise (resolve, reject) ->
    npm.load conf, (err) ->
      if err then reject err
      resolve npm
    return

getPackage = (npm, pkgdir) ->
  new Promise (resolve, reject) ->
    readJson path.resolve(pkgdir, 'package.json'), (err, pkg) ->
      if err then reject err
      resolve new Package npm, pkgdir, pkg
    return

class Package
  constructor: (@npm, @wd, pkg) ->
    extend @, pkg

    env = makeEnv pkg
    @conf = cwd: @wd, env: env, shell: yes

    if process.platform is 'win32' then conf.windowsVerbatimArguments = true

  exec: (script) -> spawnSync "npm #{script}", @conf

  run: (script) -> @exec "run #{script}"

  outdated: () -> @exec 'outdated'

  install: () -> @exec 'install'

  update: () -> @exec 'update'

exec = (wd, pkg, script) ->
  env = makeEnv pkg

  conf = cwd: wd, env: env, shell: yes

  if process.platform is 'win32' then conf.windowsVerbatimArguments = true

  out = spawnSync "npm #{script}", conf

module.exports =
  getPackage: (wd) -> getNpm().then (npm) -> getPackage npm, wd
