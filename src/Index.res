%%raw(`import "../dist/tailwind.css"`)

switch ReactDOM.querySelector("#app") {
| Some(root) =>
  ReactDOM.render(
    <ReactRedux.Provider store=Store.default> <UserAuth /> </ReactRedux.Provider>,
    root,
  )
| None => Js.log("No id named app in index.html")
}
