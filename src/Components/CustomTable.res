open MaterialUICore

let formatLabelToId = label =>
  label->Js.String2.toLowerCase->Js.String2.replaceByRe(%re(`/ /g`), "-")

@react.component
let make = (
  ~tableHeader: array<UiTypes.header>,
  ~onEdit: option<Js.Dict.t<string> => unit>=?,
  ~id=?,
  ~tableData: array<Js.Dict.t<string>>,
) => {
  let {isLightTheme} = ReactRedux.useSelector(store => store.app)
  let className = `break-all max-w-[310px] dark:text-[rgba(246,248,249,0.75)] ${isLightTheme
      ? "bg-white"
      : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)]"}`

  <TableContainer
    ?id
    className={`border-2 mt-2 w-full h-[70%] dark:text-[rgba(246,248,249,0.75)] ${isLightTheme
        ? "bg-white"
        : "bg-[rgba(33,36,38,1)] text-[rgba(246,248,249,0.6)]"}`}>
    <Table stickyHeader=true>
      <TableHead className>
        <TableRow className>
          {tableHeader
          ->Js.Array2.mapi((ele, i) =>
            <TableCell
              key={i->Belt.Int.toString}
              className
              align=?ele.align
              id={ele.label->formatLabelToId ++ i->Belt.Int.toString}>
              {React.string(ele.label)}
            </TableCell>
          )
          ->React.array}
          {onEdit->Belt.Option.isSome
            ? <TableCell className id="update-content" align="center">
                {React.string("Update")}
              </TableCell>
            : React.null}
        </TableRow>
      </TableHead>
      <TableBody>
        {tableData
        ->Js.Array2.mapi((ele, rowIndex) =>
          <TableRow key={rowIndex->Belt.Int.toString}>
            {tableHeader
            ->Js.Array2.mapi((headerField, i) => {
              let data = ele->Js.Dict.get(headerField.label)->Belt.Option.getWithDefault("")
              <TableCell
                className
                key={Belt.Int.toString(i)}
                id={headerField.label->formatLabelToId ++ rowIndex->Belt.Int.toString}>
                {React.string(data)}
              </TableCell>
            })
            ->React.array}
            {onEdit->Belt.Option.mapWithDefault(React.null, onEdit =>
              <TableCell className>
                <button
                  className="border-2 rounded p-1"
                  id={"Edit-" ++ rowIndex->Belt.Int.toString}
                  onClick={_ev => onEdit(ele)}>
                  {"Edit"->React.string}
                </button>
              </TableCell>
            )}
          </TableRow>
        )
        ->React.array}
      </TableBody>
    </Table>
  </TableContainer>
}
