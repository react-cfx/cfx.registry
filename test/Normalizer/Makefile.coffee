import dd from 'ddeyes'
import 'shelljs/make'
import Path from 'path'
import jsonfile from 'jsonfile'

JF =
  ddeyes: Path.join __dirname
  , './data/ddeyes.json'

target.ddeyes = =>
  ddeyes = jsonfile.readFileSync JF.ddeyes
  dd Object.keys ddeyes

target.all = =>

  dd 'Hello world!!!'
