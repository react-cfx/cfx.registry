import { get } from 'microrouter'
import Root, {
  packages
} from './Route'

export default [

  get '/', Root

  get (
    new UrlPattern /^\/([^\/]+)(?:\/(.+[^\/]))?(?:\/)?$/
    , [
      'package'
      'tag_or_version'
    ]
  ), packages

]
