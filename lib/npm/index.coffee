path = require 'path'

npm = require 'npm/lib/npm'
npmconf = require 'npm/lib/config/core'
Promise = require 'promise'
readJson = require 'read-package-json'
nopt = require 'nopt'

Package = require './package'

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
      resolve if err then {} else new Package pkgdir, pkg
      return
    return

module.exports =
  getNpm: getNpm
  
  getPackage: (wd) -> getNpm().then (npm) -> getPackage npm, wd
