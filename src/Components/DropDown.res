open MaterialUICore

@react.component
let make = (
  ~className=?,
  ~options: array<string>,
  ~value: string,
  ~onChange: string => unit,
  ~placeholder=?,
  ~id=?,
) => {
  let {isLightTheme} = ReactRedux.useSelector(store => store.app)
  let options =
    options->Js.Array2.mapi((option, i) =>
      <MenuItem
        className={`font-sans font-medium text-xs leading-3 not-italic ${isLightTheme
            ? ""
            : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] hover:bg-[rgba(246,248,249,0.1)]"}`}
        key={i->Belt.Int.toString}
        value=option>
        {React.string(option)}
      </MenuItem>
    )
  placeholder->Belt.Option.mapWithDefault((), placeholderText =>
    options
    ->Js.Array2.push({
      <MenuItem className="hidden" key={-1->Belt.Int.toString} value=placeholderText>
        {React.string(placeholderText)}
      </MenuItem>
    })
    ->ignore
  )
  <div ?className>
    <Select
      ?id
      className={`w-max min-w-[150px] h-10 pl-[2px] mx-[5px] flex items-center justify-evenly text-xs font-sans ${isLightTheme
          ? ""
          : "text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.6)] bg-[rgba(33,36,38,1)]"}`}
      value={value->Js.Json.string}
      \"MenuProps"={makeMenuProps(
        ~\"PaperProps"=makePaperProps(
          ~className=?{isLightTheme ? None : Some("bg-[rgba(33,36,38,1)]")},
          (),
        ),
        (),
      )}
      onChange={event => onChange({event->ReactEvent.Form.target}["value"])}>
      {options->React.array}
    </Select>
  </div>
}
