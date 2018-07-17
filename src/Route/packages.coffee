import { send } from 'micro'
import dd from 'ddeyes'
import * as api from '../api'
import Normalizer from '../Normalizer/package'
import jsonFile, {
  readJson 
} from '../jsonFile'

export default (req, res) =>

  packageName = req.params.package
  tagOrVersion = req.params.tag_or_version

  try
    data = await api.packages packageName, tagOrVersion
  catch e
    dd e
    data = readJson packageName
    send res, 200
    , data

  if data?.name?

    pkgName = data.name
    await jsonFile Normalizer data
    data = readJson pkgName

    # unless fileUrl is ''
    #   data.versions["#{data["dist-tags"].latest}"].dist.tarball = fileUrl

    send res, 200
    , data
  
  else 

    send res, 200
    ,
      errorMsg: 'no name founded in data'
