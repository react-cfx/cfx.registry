# import dd from 'ddeyes'
import fs from 'fs'
import Path from 'path'
import crypto from 'crypto'

import jsonfile from 'jsonfile'
import download from 'download'
import makeDir from 'make-dir'

import config from './config'
import { decode } from './Normalizer/package'

writeJson = (jsonData) =>

  {
    packages
    versions
  } = jsonData

  pkgName = packages.keys[0]
  pkgDir = Path.join "#{config.jsonPath}", "/#{pkgName}"
  lastVersion = packages.all[pkgName]["dist-tags"].latest
  latestTarball = versions
  .all["#{pkgName}@#{lastVersion}"]
  .dist.tarball
  file = "#{pkgDir}/#{pkgName}-#{lastVersion}.tgz"

  unless fs.existsSync file

    unless fs.existsSync pkgDir
      await makeDir pkgDir
    else unless (fs.statSync pkgDir).isDirectory()
      fs.unlinkSync pkgDir
      await makeDir pkgDir

    await download latestTarball, pkgDir

    h = crypto.createHash 'sha1'
    data = fs.readFileSync file
    h.update data
    shasum = h.digest 'hex'

    if config.pkgCache is true
      versions.all["#{pkgName}@#{lastVersion}"].dist.tarball =
        "#{config.downloadPreUrl}/#{pkgName}/#{pkgName}-#{lastVersion}.tgz"

    if shasum is jsonData.versions.all["#{pkgName}@#{lastVersion}"].dist.shasum

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
      versions.all["#{pkgName}@#{lastVersion}"].dist.tarball =
        "#{config.downloadPreUrl}/#{pkgName}/#{pkgName}-#{lastVersion}.tgz"

  versions.all["#{pkgName}@#{lastVersion}"].dist.tarball

readJson = (pkgName) =>

  pkgDir = Path.join "#{config.jsonPath}", "/#{pkgName}"
  packages = jsonfile.readFileSync Path.join pkgDir, './package.json'
  versions = jsonfile.readFileSync Path.join pkgDir, './version.json'

  decode {
    packages
    versions
  }

export {
  writeJson
  readJson
}

export default writeJson
