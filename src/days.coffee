import dayjs from 'dayjs'

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

export {
  getNow
  diffDays
}
