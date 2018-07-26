import { send } from 'micro'
import dd from 'ddeyes'
import * as api from '../api'
import Normalizer from '../Normalizer/package'
import config from '../config'
import jsonFile, {
  readJson
} from '../jsonFile'
import {
  getNow
  getPkgDay
  diffDays
} from '../days'

export default (req, res) =>

  packageName = req.params.package.replace '%2f', '/'
  tagOrVersion = req.params.tag_or_version

  data = readJson packageName

  now = getNow()
  diffDay = diffDays now.now, (
    getPkgDay packageName
  )

  if data?.name? and (
    data.name is packageName
  ) and (
    diffDay < config.diffDay
  )

    dd "1: #{now.format}"
    dd data.versions["#{data["dist-tags"].latest}"].dist.tarball
    send res, 200
    , data

  else

    try
      data = await api.packages packageName, tagOrVersion
    catch e
      dd e
      data = readJson packageName

      dd "2: #{now.format}"
      dd data.versions["#{data["dist-tags"].latest}"].dist.tarball
      # dd (Normalizer data).packages
      send res, 200
      , data

    if data?.name? and (
      data.name is packageName
    )

      await jsonFile Normalizer data
      data = readJson packageName

      # unless fileUrl is ''
      #   data.versions["#{data["dist-tags"].latest}"].dist.tarball = fileUrl

      dd "3: #{now.format}"
      # dd (Normalizer data).packages
      dd data.versions["#{data["dist-tags"].latest}"].dist.tarball
      send res, 200
      , data
    
    else 

      send res, 200
      ,
        errorMsg: 'no name founded in data'
