external toReactEvent: 'a => ReactEvent.Form.t = "%identity"

let enterKeyCode = 13

let preventSubmitOnEnter = (ev: ReactEvent.Keyboard.t) => {
  let keyCode = ev->ReactEvent.Keyboard.keyCode
  if keyCode == enterKeyCode {
    ev->ReactEvent.Keyboard.preventDefault
  }
}

@val @scope(("navigator", "clipboard"))
external writeToClipboard: string => Promise.t<'a> = "writeText"

let stringToFloat = element => {
  switch Belt.Float.fromString(element) {
  | Some(a) => a
  | _ => 0.0
  }
}
