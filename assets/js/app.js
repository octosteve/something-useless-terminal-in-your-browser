import Terminal from 'xterm'
import socket from './socket'

let channel = socket.channel("terminal:1", {})
channel.join()
channel.on('output', ({output}) => term.write(output))

let term = new Terminal({
  cursorBlink: true,
})


term.open(document.getElementById('terminal-container'))
term.on('data', (data) => channel.push('input', {input: data}))
