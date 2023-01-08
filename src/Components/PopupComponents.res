open MaterialUICore

module ItemsEditor = {
  @react.component
  let make = (
    ~isLightTheme,
    ~currentValue: array<Js.Json.t>,
    ~onChange: array<Js.Json.t> => unit,
  ) => {
    let (strVal, setStrVal) = React.useState(_ => "")

    let handleDelete = (_, val) => {
      onChange(
        currentValue->Js.Array2.filter(item =>
          item->Parser.jsonToString !== val->Parser.jsonToString
        ),
      )
    }

    let onClick = _ev => {
      if strVal->Js.String.length > 0 {
        let newArr = []
        currentValue->Js.Array2.map(x => newArr->Js.Array2.push(x))->ignore
        newArr->Js.Array2.push(strVal->Js.Json.string)->ignore
        onChange(newArr)
        setStrVal(_ => "")
      }
    }

    let handleChange = ev => {
      let value = ReactEvent.Form.target(ev)["value"]
      let checkedValue = value->Js.String2.trim
      setStrVal(_ => checkedValue)
    }

    <div className="flex flex-row w-full">
      <div className="flex flex-col">
        <div className="text-component flex flex-row mb-6">
          <input
            className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
                ? "bg-white"
                : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
            name="textInput"
            value=strVal
            onChange={handleChange}
            onKeyDown={Utils.preventSubmitOnEnter}
            autoComplete="off"
          />
          <MaterialUICore.Tooltip
            \"TransitionComponent"=MaterialUICore.zoom
            title={React.string("Add new entry")}
            placement=#"right-start">
            <div
              className={`flex flex-row self-center cursor-pointer ml-[18px] h-[30px] py-[2px] px-[10px] font-sans font-bold border-[2px] dark:text-[rgba(122,195,232,0.75)]  ${isLightTheme
                  ? "bg-white"
                  : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
              onClick>
              <span
                className={`w-max dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
                    ? "bg-white"
                    : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] dark:border-[rgba(246,248,249,0.1)]"}`}>
                {React.string("Add")}
              </span>
            </div>
          </MaterialUICore.Tooltip>
        </div>
        <div className="flex overflow-hidden flex-wrap">
          {currentValue
          ->Js.Array2.mapi((item, i) =>
            <div key={i->Belt.Int.toString} className="m-[3px]">
              <MaterialUICore.Chip
                className="bg-[rgba(33,36,38,0.25)] dark:bg-white text-[rgba(100,100,100,1)] border-[rgba(246,248,249,0.1)]"
                label={item->Parser.jsonToString}
                onDelete={_ => handleDelete(_, item)}
              />
            </div>
          )
          ->React.array}
        </div>
      </div>
    </div>
  }
}

module RenderChip = {
  @react.component
  let make = (~selected: Js.Json.t, ~isLightTheme, ~onChange) => {
    let handleDelete = (_, val) => {
      onChange(
        selected
        ->Js.Json.decodeArray
        ->Belt.Option.mapWithDefault([], selected =>
          selected->Js.Array2.filter(item => item->Parser.jsonToString !== val->Parser.jsonToString)
        )
        ->Utils.toReactEvent,
      )
    }
    <div className="overflow-y-auto">
      {selected
      ->Js.Json.decodeArray
      ->Belt.Option.mapWithDefault(React.null, selected => {
        selected
        ->Js.Array2.mapi((item, i) =>
          <Chip
            key={i->Belt.Int.toString}
            className={`dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
                ? ""
                : "text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
            label={item->Parser.jsonToString}
            // deleteIcon={<Icons.CloseIcon
            //   onMouseDown={(event: ReactEvent.Mouse.t) => event->ReactEvent.Mouse.stopPropagation}
            // />}
            onDelete={_ => handleDelete(_, item)}
          />
        )
        ->React.array
      })}
    </div>
  }
}

module TextInput = {
  @react.component
  let make = (
    ~input: ReactFinalForm.fieldRenderPropsInput,
    ~isLightTheme: bool,
    ~required=?,
    ~fieldInputProps: UiTypes.fieldInput,
  ) => {
    <input
      id={fieldInputProps.id ++ "-input"}
      className={`border-[1px] border-black rounded p-[4px] dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
          ? "bg-white"
          : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
      placeholder=fieldInputProps.placeholderText
      value={input.value->Parser.jsonToString}
      onChange=input.onChange
      ?required
    />
  }
}

module DropDown = {
  @react.component
  let make = (
    ~input: ReactFinalForm.fieldRenderPropsInput,
    ~isLightTheme: bool,
    ~options: array<UiTypes.dropDownOption>,
    ~fieldInputProps: UiTypes.fieldInput,
  ) => {
    <select
      id=fieldInputProps.id
      className={`border-[1px] border-black rounded cursor-pointer dark:text-[rgba(122,195,232,0.75)] ${isLightTheme
          ? "bg-white"
          : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)] border-[rgba(246,248,249,0.1)]"}`}
      placeholder=fieldInputProps.placeholderText
      value={input.value->Parser.jsonToString}
      onChange={ev => {
        let text = {ev->ReactEvent.Form.target}["value"]
        input.onChange(text->Utils.toReactEvent)
      }}>
      {options
      ->Js.Array2.mapi((item, i) => {
        let (value, ele) = switch item {
        | Value(st) => (st, st)
        | ValueLabelPair(pair) => pair
        }
        <option key={Belt.Int.toString(i + 1)} value id=ele> {ele->React.string} </option>
      })
      ->React.array}
    </select>
  }
}

module InputView = {
  @react.component
  let make = (~fieldInputProps: UiTypes.fieldInput) => {
    let {isLightTheme} = ReactRedux.useSelector(store => store.app)
    switch fieldInputProps.fieldType {
    | #NonEditable =>
      <div
        className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
        id=fieldInputProps.id>
        {React.string(fieldInputProps.label)}
        <ReactFinalForm.Field
          name=fieldInputProps.key
          render={({input}) => <div> {React.string(input.value->Parser.jsonToString)} </div>}
        />
      </div>
    | #TextInput(props) =>
      <div
        className="flex flex-col mr-2.5 w-[250px] h-[60px] border-[rgba(246,248,249,0.1)]"
        id=fieldInputProps.id>
        {React.string(fieldInputProps.label)}
        <ReactFinalForm.Field
          name=fieldInputProps.key
          render={({input}) => {
            <TextInput input isLightTheme required={props["required"]} fieldInputProps />
          }}
        />
      </div>
    | #DropDown(props) =>
      <div className="flex flex-col mr-2.5 w-[250px] h-[60px] justify-center" id=fieldInputProps.id>
        <div className="mr-2.5"> {React.string(fieldInputProps.label)} </div>
        <ReactFinalForm.Field
          name=fieldInputProps.key
          render={({input}) => {
            <DropDown input isLightTheme options={props["options"]} fieldInputProps />
          }}
        />
      </div>
    | #Chip =>
      <div className="flex flex-col mr-2.5 w-[250px] h-fit" id=fieldInputProps.id>
        {React.string(fieldInputProps.label)}
        <ReactFinalForm.Field
          name=fieldInputProps.key
          render={({input}) => {
            <ItemsEditor
              isLightTheme
              currentValue={input.value->Parser.jsonToArray}
              onChange={value => input.onChange(value->Utils.toReactEvent)}
            />
          }}
        />
      </div>
    }
  }
}

module OutputView = {
  @react.component
  let make = (~fieldInputProps: UiTypes.fieldOutput) => {
    switch fieldInputProps.fieldType {
    | #Table(props) =>
      <CustomTable
        onEdit=?props.onEdit
        id=fieldInputProps.id
        tableHeader=props.headerFields
        tableData=props.list
      />
    }
  }
}
