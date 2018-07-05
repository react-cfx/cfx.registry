import dd from 'ddeyes'
import 'shelljs/make'
import request from 'cfx.service.request'
import UrlPattern from 'url-pattern'

import fs from 'fs'
import path from 'path'
import crypto from 'crypto'

target.pattern = =>

  myPattern = new UrlPattern(
    /^\/([^\/]+)(?:\/(.+[^\/]))?(?:\/)?$/
    [
      'package'
      'tag_or_version'
    ]
  )

  dd myPattern.match '/ddeyes'
  dd myPattern.match '/ddeyes/'
  dd myPattern.match '/ddeyes/0.2.8'
  dd myPattern.match '/ddeyes/0.2.8/'

target.ddeyes = =>

  data = await request 'https://registry.npm.taobao.org/ddeyes'

  dd data

target.all = =>

  data = await request 'http://localhost:3000/ddeyes'

  dd data

target.sha1 = =>

  file = path.join __dirname, '../Config/ConfigDir/data/ddeyes/ddeyes-0.2.11.tgz'
  h = crypto.createHash 'sha1'
  data = fs.readFileSync file
  h.update data
  dd h.digest 'hex'
