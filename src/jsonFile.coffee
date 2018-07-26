import dd from 'ddeyes'
import fs from 'fs'
import Path from 'path'
import crypto from 'crypto'

import jsonfile from 'jsonfile'
import download from 'download'
import makeDir from 'make-dir'

import config from './config'
import { decode } from './Normalizer/package' 
import {
  getNow
} from './days'

writeJson = (jsonData) =>

  {
    packages
    versions
  } = jsonData

  groups = packages.keys[0].split '/'

  if groups.length is 2
    groupName = groups[0]
    pkgName = groups[1]
    groupPkgName = "#{groupName}/#{pkgName}"
  else 
    groupName = ''
    pkgName = groups[0]
    groupPkgName = pkgName

  pkgDir = Path.join config.jsonPath, groupPkgName

  lastVersion = packages.all[groupPkgName]["dist-tags"].latest
  latestTarball = versions
  .all["#{groupPkgName}@#{lastVersion}"]
  .dist.tarball

  file = "#{pkgDir}/#{pkgName}-#{lastVersion}.tgz"

  # dd {
  #   groupPkgName
  #   groupName
  #   pkgName
  #   pkgDir
  #   lastVersion
  #   latestTarball
  #   file
  # }

  unless fs.existsSync pkgDir
    await makeDir pkgDir
  else unless (fs.statSync pkgDir).isDirectory()
    fs.unlinkSync pkgDir
    await makeDir pkgDir

  fs.writeFileSync "#{pkgDir}/create.txt", getNow().format

  unless fs.existsSync file

    await download latestTarball, pkgDir

    h = crypto.createHash 'sha1'
    data = fs.readFileSync file
    h.update data
    shasum = h.digest 'hex'

    if config.pkgCache is true
      versions.all["#{groupPkgName}@#{lastVersion}"].dist.tarball =
        "#{config.downloadPreUrl}/#{groupPkgName}/#{pkgName}-#{lastVersion}.tgz"

    if shasum is jsonData.versions.all["#{groupPkgName}@#{lastVersion}"].dist.shasum

      fs.writeFileSync "#{pkgDir}/shasum.txt", shasum

      [
        'package'
        'version'
      ].forEach (jsonName) =>
        jsonfile.writeFileSync(
          "#{pkgDir}/#{jsonName}.json"
          jsonData["#{jsonName}s"]
          spaces: 2
          EOL: '\r\n'
        )

  else

    if config.pkgCache is true
      versions.all["#{groupPkgName}@#{lastVersion}"].dist.tarball =
        "#{config.downloadPreUrl}/#{groupPkgName}/#{pkgName}-#{lastVersion}.tgz"

  versions.all["#{groupPkgName}@#{lastVersion}"].dist.tarball

readJson = (pkgName) =>

  pkgDir = Path.join "#{config.jsonPath}", "/#{pkgName}"

  if fs.existsSync pkgDir

    packages = jsonfile.readFileSync Path.join pkgDir, './package.json'
    versions = jsonfile.readFileSync Path.join pkgDir, './version.json'

    decode {
      packages
      versions
    }

  else ''

export {
  writeJson
  readJson
}

export default writeJson
