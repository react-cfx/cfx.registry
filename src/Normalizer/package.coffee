import { normalize, schema } from 'normalizr'

export default (data) =>

  packageSchema =
    new schema.Entity 'package'
    , {}
    ,
      idAttribute: '_rev'

  schemaDef.array = new schema.Array schemaDef.object

  normalizer =
    if Array.isArray data
    then normalize data, schemaDef.array
    else normalize data, schemaDef.object

  all: normalizer.entities[name]
  keys: normalizer.result
