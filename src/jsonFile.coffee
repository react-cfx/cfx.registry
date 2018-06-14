import dd from 'ddeyes'
import fs from 'fs'
import Path from 'path'
import jsonfile from 'jsonfile'
import config from './config'
import download from 'download'

export default (jsonData) =>

  {
    packages
    versions
  } = jsonData

  pkgName = packages.keys[0]
  pkgDir = Path.join "#{config.jsonPath}", "/#{pkgName}"

  unless fs.existsSync pkgDir
    fs.mkdirSync pkgDir
  else unless (fs.statSync pkgDir).isDirectory()
    fs.unlinkSync pkgDir
    fs.mkdirSync pkgDir

  jsonfile.writeFileSync(
    "#{pkgDir}/package.json"
    packages
    spaces: 2
    EOL: '\r\n'
  )

  jsonfile.writeFileSync(
    "#{pkgDir}/versions.json"
    versions
    spaces: 2
    EOL: '\r\n'
  )

  latestTarball = versions.all["#{pkgName}@#{packages.all[pkgName]['dist-tags'].latest}"].dist.tarball

  await download latestTarball, pkgDir
