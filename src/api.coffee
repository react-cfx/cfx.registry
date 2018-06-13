import reTryRequest from './reTryRequest'

export packages = (
  packageName
  tagOrVersion
) =>

  await reTryRequest (preUrl) =>
    unless tagOrVersion?
    then "#{preUrl}/#{packageName}"
    else "#{preUrl}/#{packageName}/#{tagOrVersion}"
