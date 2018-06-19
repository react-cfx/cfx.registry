import dd from 'ddeyes'
import fs from 'fs'
import Path from 'path'
import relative from 'relative'
import getRequire, { gdf } from 'cfx.require'
import coffee from 'cfx.require-plugin-coffee'

CS = getRequire [
  coffee()
]

defaultConfig =

  Registry: [
    'https://registry.npm.taobao.org'
    'https://registry.yarnpkg.com'
    'https://registry.npmjs.org'
  ]

  reTryTimes: 3

  jsonPath: Path.join __dirname
  , "../test/Normalizer/data"

configFileName = 'cfx.registry.coffee'
# userConfig = [
#   "#{process.cwd()}/#{configFileName}"
#   "/registry/config/#{configFileName}"
# ].reduce (r, c) =>
#   return r unless r is ''
#   if fs.existsSync c
#     dd relative __dirname, c
#     try
#       r = CS.require relative __dirname, c
#     catch e
#       console.error e
#       throw new Error e
#   else r
# , ''

userConfig = CS.require '../test/Config/ConfigDir/cfx.registry.coffee'

dd userConfig

export default defaultConfig
