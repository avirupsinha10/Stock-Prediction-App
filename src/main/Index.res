switch ReactDOM.querySelector("#app") {
| Some(root) =>
  ReactDOM.render(
    <div>
      <Component/>
    </div>,
    root,
  ) 
| None => Js.log("No id named app in index.html")
}