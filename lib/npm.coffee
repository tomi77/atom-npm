path = require 'path'
{spawnSync} = require 'child_process'

npm = require 'npm/lib/npm'
npmconf = require 'npm/lib/config/core'
{makeEnv} = require 'npm/lib/utils/lifecycle'
Promise = require 'promise'
readJson = require 'read-package-json'
nopt = require 'nopt'

configDefs = npmconf.defs
shorthands = configDefs.shorthands
types = configDefs.types
conf = nopt types, shorthands

getNpm = () ->
  new Promise (resolve, reject) ->
    npm.load conf, (err) ->
      if err then reject err
      npm.localPrefix = atom.project.getDirectories()[0].path
      resolve npm
    return

getPackage = (npm) ->
  pkgdir = npm.localPrefix

  new Promise (resolve, reject) ->
    readJson path.resolve(pkgdir, 'package.json'), (err, pkg) ->
      if err then reject err
      resolve pkg
    return

exec = (wd, pkg, script) ->
  env = makeEnv pkg

  conf = cwd: wd, env: env, shell: yes

  if process.platform is 'win32' then conf.windowsVerbatimArguments = true

  out = spawnSync "npm #{script}", conf

module.exports =
  getPackage: () -> getNpm().then (npm) -> getPackage npm

  run: (wd, pkg, script) -> exec wd, pkg, "run #{script}"

  outdated: (wd, pkg) -> exec wd, pkg, 'outdated'

  install: (wd, pkg) -> exec wd, pkg, 'install'

  update: (wd, pkg) -> exec wd, pkg, 'update'
