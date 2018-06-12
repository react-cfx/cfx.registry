import { send } from 'micro'
import UrlPattern from 'url-pattern'
import jsonfile from 'jsonfile'
import Path from 'path'
import config from '../config'

import * as api from './api'

export default (req, res) =>

  packageName = req.params.package
  tagOrVersion = req.params.tag_or_version

  try
    data = await api.packages packageName, tagOrVersion
  catch e
    dd e()

  jsonfile.writeFileSync(
    Path.join "#{config.jsonPath}", "#{data.name}.json"
    data
    spaces: 2
    EOL: '\r\n'
  ) if data?

  send res, 200
  , data
