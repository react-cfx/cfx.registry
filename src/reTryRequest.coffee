import dd from 'ddeyes'
import request from 'cfx.service.request'
import config from './config'

{
  Registry
  reTryTimes
} = config

recReTryRequest = (
  urlFactory
  flag = 0
  reTryTime = 1
) =>

  requestUrl = urlFactory Registry[flag]

  try

    dd "Try to request registry #{requestUrl}"

    data = await request requestUrl
    ,
      method: 'GET'

  catch e

    dd "Faild of try to request registry #{requestUrl} #{reTryTime} times"

    data =
      if reTryTime < reTryTimes
      then await recReTryRequest urlFactory, flag, (reTryTime + 1)
      else (
        unless flag is (registryUrl.length - 1)
        then await recReTryRequest urlFactory, flag + 1, reTryTime
        else e
      )

  data

export default recReTryRequest
