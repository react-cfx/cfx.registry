# import dd from 'ddeyes'
import fs from 'fs'
import Path from 'path'

defaultConfig =

  Registry: [
    'https://registry.npm.taobao.org'
    'https://registry.yarnpkg.com'
    'https://registry.npmjs.org'
  ]

  reTryTimes: 3

  jsonPath: Path.join __dirname
  , "../test/Normalizer/data"


  pkgCache: false
  downloadPreUrl: "http://download.cfx.registry:3000"

  diffDay: 1

configFileName = 'cfx.registry'

userConfig = [
  "#{process.cwd()}"
  "/cfx.registry/config"
].reduce (r, c) =>

  return r unless r is ''

  requireFile = "#{c}/#{configFileName}"

  if fs.existsSync "#{requireFile}.js"
    try
      r = require requireFile
    catch e
      console.error e
      throw new Error e
  else r
, ''

result =
  unless userConfig is ''
  then {
    defaultConfig...
    userConfig...
  }
  else defaultConfig

export default result
