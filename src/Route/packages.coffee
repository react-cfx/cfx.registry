import { send } from 'micro'
# import dd from 'ddeyes'
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

  # delete data.versions["#{data["dist-tags"].latest}"]._npmOperationalInternal

  fileUrl = await jsonFile Normalizer data if data?.name?

  unless fileUrl is ''
    data.versions["#{data["dist-tags"].latest}"].dist.tarball = fileUrl

  send res, 200
  , data
