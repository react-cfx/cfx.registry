# import dd from 'ddeyes'
import {
  normalize
  denormalize
  schema
} from 'normalizr'

encode = (data) =>

  versionSchema = new schema.Entity 'versions'
  , {}, idAttribute: '_id'

  data = {
    data...
    (
      denormalize
        versions: Object.keys data.versions
      ,
        versions: [ versionSchema ]
      ,
        versions: data.versions
    )...
  }

  packageSchema =
    new schema.Entity 'packages'
    ,
      versions: new schema.Array versionSchema
    ,
      idAttribute: '_id'

  newPackageSchema =
    new schema.Entity 'packages'
    , {}
    ,
      idAttribute: '_id'

  {
    packages
    versions
  } = (
    normalize data, packageSchema
  ).entities

  _packages = normalize (
    denormalize
      packages: Object.keys packages
    ,
      packages: [ newPackageSchema ]
    , { packages }
  ), packages: new schema.Array newPackageSchema

  _versions = normalize (
    denormalize
      versions: Object.keys versions
    ,
      versions: [ versionSchema ]
    , { versions }
  ), versions: new schema.Array versionSchema

  # all: {
  #   _packages.entities...
  #   _versions.entities...
  # }
  # keys: {
  #   _packages.result...
  #   _versions.result...
  # }

  packages: 
    all: _packages.entities.packages
    keys: _packages.result.packages
  versions:
    all: _versions.entities.versions
    keys: _versions.result.versions

decode = ({
  packages
  versions
}) =>

  pkgName = packages.keys[0]

  {
    packages.all[pkgName]...
    versions: packages.all[pkgName].versions.reduce (r, c) =>
      { version } = versions.all[c]
      {
        r...
        "#{version}": versions.all[c]
      }
    , {}
  }

export {
  encode
  decode
}

export default encode
