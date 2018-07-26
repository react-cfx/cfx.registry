import dd from 'ddeyes'
import dayjs from 'dayjs'
import config from './config'
import fs from 'fs'
import Path from 'path'

getNow = (
  formater = 'YYYYMMDDHHmmss'
) =>
  now = dayjs new Date()
  {
    now
    format: now.format formater
  }

diffDays = (
  dayObj
  diffDateStr
) =>
  (dayjs dayObj.format 'YYYYMMDD').diff(
    dayjs diffDateStr
    'days'
  )

getPkgDay = (pkgName) =>
  pkgDir = Path.join config.jsonPath, pkgName
  file = "#{pkgDir}/create.txt"
  createDate =
    try
      fs.readFileSync file, 'utf-8'
    catch e
      createDate = getNow().format
  createDate[0..7]

export {
  getNow
  getPkgDay
  diffDays
}
