path = require 'path'

npm = require 'npm/lib/npm'
Promise = require 'promise'
readJson = require 'read-package-json'

Package = require './package'

getNpm = () ->
  new Promise (resolve, reject) ->
    npm.load (err) ->
      if err then reject err
      resolve npm
    return

getPackage = (npm, pkgdir) ->
  new Promise (resolve, reject) ->
    readJson path.resolve(pkgdir, 'package.json'), (err, pkg) ->
      resolve if err then {} else new Package pkgdir, pkg, npm
      return
    return

module.exports =
  getNpm: getNpm

  getPackage: (wd) -> getNpm().then (npm) -> getPackage npm, wd
