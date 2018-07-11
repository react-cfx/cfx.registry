import Path from 'path'

export default

  Registry: [
    'https://registry.npm.taobao.org'
    'https://registry.yarnpkg.com'
    'https://registry.npmjs.org'
  ]

  jsonPath: Path.join __dirname
  , "../data"

  pkgCache: true
  downloadPreUrl: "http://download.cfx.registry"
