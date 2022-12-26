type environment = [#prod | #sandbox | #integ]

type user = {
  username: string,
  token: string,
  merchantId: string,
  email: string,
  context: string,
}

type appState = {mutable user: user}
