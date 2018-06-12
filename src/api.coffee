import dd from 'ddeyes'
import config from './config'

{
  Registry
  reTryTimes
} = config

export packages = (
  packageName
  tagOrVersion
  flag = 0
  reTryTime = 1
) =>

  requestUrl =
    unless tagOrVersion?
    then "#{Registry[flag]}/#{packageName}"
    else "#{Registry[flag]}/#{packageName}/#{tagOrVersion}"

  try

    dd "Try to request registry #{requestUrl}"

    data = await request requestUrl
    ,
      method: 'GET'

  catch e

    dd "Faild of try to request registry #{requestUrl} #{reTryTime} times"

    data =
      if reTryTime < reTryTimes
      then await getData packageName, tagOrVersion, flag, (reTryTime + 1)
      else (
        unless flag is (registryUrl.length - 1)
        then await getData packageName, tagOrVersion, flag + 1
        else e
      )

  data