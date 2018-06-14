import { send } from 'micro'
import dd from 'ddeyes'
import * as api from '../api'
import Normalizer from '../Normalizer/package'
import jsonFile from '../jsonFile'

export default (req, res) =>

  packageName = req.params.package
  tagOrVersion = req.params.tag_or_version

  try
    data = await api.packages packageName, tagOrVersion
  catch e
    dd e

  jsonFile Normalizer data if data?.name?

  send res, 200
  , data
