import dd from 'ddeyes'
import { get } from 'microrouter'
import { send } from 'micro'
import { request } from 'cfx.service'
import UrlPattern from 'url-pattern'

# registryUrl = 'https://registry.npmjs.org'
registryUrl = 'https://registry.npm.taobao.org'

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

    send res, 200
    , data

]
