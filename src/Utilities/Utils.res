external toReactEvent: 'a => ReactEvent.Form.t = "%identity"

let enterKeyCode = 13

let preventSubmitOnEnter = (ev: ReactEvent.Keyboard.t) => {
  let keyCode = ev->ReactEvent.Keyboard.keyCode
  if keyCode == enterKeyCode {
    ev->ReactEvent.Keyboard.preventDefault
  }
}
