@react.component
let make = (~id, ~onChange, ~inputText, ~placeholder) => {
  let {isLightTheme} = ReactRedux.useSelector(store => store.app)
  let handleSearch = e => {
    let searchStr = (e->ReactEvent.Form.target)["value"]
    onChange(searchStr)
  }
  let clearSearch = _ => {
    onChange("")
  }
  let borderClass = "border rounded-md pl-1 pr-2"
  <div
    className={`${borderClass} ml-10 mt-4 mb-2 w-[250px] h-10 flex flex-row items-center justify-between bg-inherit border border-[rgba(204, 210, 226, 0.75)] hover:border-opacity-100 dark:bg-[rgba(25,26,26,1)] dark:border-[rgba(246,248,249,0.1)]`}>
    <Icons.Search className="text-[rgba(53,64,82,1)] dark:brightness-0 dark:invert" />
    <input
      id
      type_="text"
      value=inputText
      onChange=handleSearch
      placeholder
      className={` w-full pl-2 focus:outline-none bg-transparent text-[rgba(0,0,0,0.87)] dark:text-[rgba(246,248,249,0.8)] ${isLightTheme
          ? "noautocompletebg"
          : "darknoautocompletebg"}`}
      autoFocus=true
    />
    {if inputText != "" {
      <div className="cursor-pointer">
        <Icons.Delete
          className="dark:brightness-0 dark:invert"
          onClick={_ => {
            clearSearch()
          }}
        />
      </div>
    } else {
      React.null
    }}
  </div>
}
