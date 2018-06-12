import Path from 'path'

export default

  Registry: [
    'https://registry.npm.taobao.org'
    'https://registry.yarnpkg.com'
    'https://registry.npmjs.org'
  ]

  reTryTimes: 3

  jsonPath: Path.join __dirname
  , "../test/Normalizer/data"
