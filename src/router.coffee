import dd from 'ddeyes'
import { get } from 'microrouter'
import { send } from 'micro'
import { request } from 'cfx.service'
import UrlPattern from 'url-pattern'
import jsonfile from 'jsonfile'
import Path from 'path'

# registryUrl = 'https://registry.npmjs.org'
# registryUrl = 'https://registry.npm.taobao.org'
registryUrl = 'https://registry.yarnpkg.com'

export default [

  get '/', (req, res) =>

    data = await request registryUrl
    ,
      method: 'GET'

    send res, 200
    , data

  get (
    new UrlPattern /^\/([^\/]+)(?:\/(.+[^\/]))?(?:\/)?$/
    , [
      'package'
      'tag_or_version'
    ]
  ), (req, res) =>

    packageName = req.params.package
    tagOrVersion = req.params.tag_or_version

    requestUrl =
      unless tagOrVersion?
      then "#{registryUrl}/#{packageName}"
      else "#{registryUrl}/#{packageName}/#{tagOrVersion}"

    try

      data = await request requestUrl
      ,
        method: 'GET'

    catch e
      data = e()

    jsonfile.writeFileSync(
      Path.join __dirname, "../test/Normalizer/data/#{data.name}.json"
      data
      spaces: 2
      EOL: '\r\n'
    ) if data?

    send res, 200
    , data

]
