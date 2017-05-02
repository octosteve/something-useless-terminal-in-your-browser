import Terminal from 'xterm'

let term = new Terminal({
  cursorBlink: true,
})

term.open(document.getElementById('terminal-container'))
term.on('data', (data) => console.log(data))
