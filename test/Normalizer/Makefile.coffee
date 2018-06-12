import dd from 'ddeyes'
import 'shelljs/make'
import Path from 'path'
import jsonfile from 'jsonfile'
import pkg from '../../src/Normalizer/package'

JF =
  ddeyes: Path.join __dirname
  , './data/ddeyes.json'

target.ddeyes = =>
  ddeyes = jsonfile.readFileSync JF.ddeyes
  dd pkg ddeyes

target.all = =>

  dd 'Hello world!!!'
