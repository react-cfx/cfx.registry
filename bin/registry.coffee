import micro from 'micro'
import service from '../src'

server = micro service

server.listen 3000
