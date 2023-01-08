type themeColor = [#primary | #secondary | #success | #error | #info | #warning]
type size = [#small | #medium | #large]
type variant = [#circular | #outlined | #contained]
type formComponent = [#legend | #fieldset]
type placement = [
  | #"auto-end"
  | #"auto-start"
  | #auto
  | #"right-end"
  | #"right-start"
  | #right
  | #"bottom-end"
  | #"bottom-start"
  | #bottom
  | #"left-end"
  | #"left-start"
  | #left
  | #"top-end"
  | #"top-start"
  | #top
]
type textFieldProps = {
  inputMode: [#numeric],
  pattern: string,
}

type paperProps
@obj
external makePaperProps: (~className: string=?, unit) => paperProps = ""

module Menu = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~className: string=?,
    ~anchorEl: Js.Nullable.t<'a>=?,
    ~keepMounted: bool=?,
    ~\"PaperProps": paperProps=?,
    ~\"open": bool,
    ~onClose: unit => unit=?,
    ~children: React.element,
  ) => React.element = "Menu"
}

module Button = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~variant: variant=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
    ~placeholder: string=?,
    ~size: size=?,
    ~className: string=?,
    ~color: [#inherit | themeColor]=?,
    ~startIcon: React.element=?,
    ~disabled: bool=?,
    ~autoFocus: bool=?,
    ~children: React.element,
    ~className: string=?,
    ~autoFocus: bool=?,
  ) => React.element = "Button"
}

module MenuItem = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~onClick: ReactEvent.Form.t => unit=?,
    ~className: string=?,
    ~children: React.element=?,
    ~value: string=?,
  ) => React.element = "MenuItem"
}

module LinearProgress = {
  @module("@mui/material") @react.component
  external make: (
    ~color: [#primary | #secondary | #inherit]=?,
    ~className: string=?,
    ~variant: [#static | #determinate | #indeterminate]=?,
    ~value: int=?,
    ~progress: int=?,
  ) => React.element = "LinearProgress"
}

module Checkbox = {
  @module("@mui/material") @react.component
  external make: (
    ~checked: bool,
    ~className: string=?,
    ~onChange: unit => unit=?,
    ~color: [#default | themeColor]=?,
    ~size: size=?,
  ) => React.element = "Checkbox"
}

module Switch = {
  @module("@mui/material") @react.component
  external make: (
    ~checked: bool,
    ~disabled: bool=?,
    ~onChange: ReactEvent.Form.t => unit=?,
    ~color: themeColor=?,
    ~size: size=?,
    ~className: string=?,
  ) => React.element = "Switch"
}

module ListItemIcon = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~className: string=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
  ) => React.element = "ListItemIcon"
}

module ListItemText = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element=?,
    ~disableTypography: bool=?,
    ~className: string=?,
    ~primary: React.element,
    ~secondary: React.element=?,
    ~defaultValue: string=?,
  ) => React.element = "ListItemText"
}

module ListItemButton = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~className: string=?,
    ~disableGutters: bool=?,
    ~id: string=?,
    ~divider: bool=?,
    ~alignItems: [#center | #"flex-start"]=?,
    ~autoFocus: bool=?,
    ~divider: bool=?,
    ~selected: bool=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
  ) => React.element = "ListItemButton"
}

module ListItem = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~children: React.element,
    ~className: string=?,
    ~disableGutters: bool=?,
    ~disablePadding: bool=?,
    ~divider: bool=?,
    ~onMouseEnter: ReactEvent.Mouse.t => unit=?,
    ~onMouseLeave: ReactEvent.Mouse.t => unit=?,
    ~onMouseOver: ReactEvent.Mouse.t => unit=?,
    ~onMouseMove: ReactEvent.Mouse.t => unit=?,
    ~onMouseOut: ReactEvent.Mouse.t => unit=?,
    ~secondaryAction: React.element=?,
  ) => React.element = "ListItem"
}

module List = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~className: string=?,
    ~disablePadding: bool=?,
    ~subheader: React.element=?,
  ) => React.element = "List"
}

type menuProps
@obj
external makeMenuProps: (~className: string=?, ~\"PaperProps": paperProps=?, unit) => menuProps = ""

module Select = {
  @module("@mui/material") @react.component
  external make: (
    ~label: string=?,
    ~id: string=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
    ~className: string=?,
    ~\"MenuProps": menuProps=?,
    ~label: string=?,
    ~placeholder: string=?,
    ~error: bool=?,
    ~required: bool=?,
    ~autoFocus: bool=?,
    ~value: Js.Json.t=?,
    ~onChange: ReactEvent.Form.t => unit,
    ~renderValue: 'a => React.element=?,
    ~children: React.element=?,
    ~displayEmpty: bool=?,
    ~multiple: bool=?,
  ) => React.element = "Select"
}

type toolTipTransitionComponent

@module("@mui/material")
external zoom: toolTipTransitionComponent = "Zoom"

module Tooltip = {
  @module("@mui/material") @react.component
  external make: (
    ~title: React.element,
    ~children: React.element,
    ~className: string=?,
    ~\"TransitionComponent": toolTipTransitionComponent=?,
    ~placement: placement=?,
    ~arrow: bool=?,
  ) => React.element = "Tooltip"
}

module TooltipWithCustomStyles = {
  @react.component
  let make = (~children: React.element, ~title: string, ~disabled=false) => {
    disabled
      ? children
      : <Tooltip
          \"TransitionComponent"=zoom
          title={<div
            className="py-1 font-sans not-italic text-[#E3E8FC] font-normal text-xs max-w-[250px]">
            {title->React.string}
          </div>}
          placement=#bottom
          arrow=true
          className="h-fit">
          children
        </Tooltip>
  }
}
module Modal = {
  @module("@mui/material") @react.component
  external make: (
    ~\"open": bool,
    ~id: string=?,
    ~onClose: unit => unit,
    ~children: React.element,
    ~className: string=?,
    ~hideBackdrop: bool=?,
    ~disableAutoFocus: bool=?,
  ) => React.element = "Modal"
}

module Grow = {
  @module("@mui/material") @react.component
  external make: (
    ~className: string=?,
    ~children: React.element,
    ~appear: bool=?,
    ~\"in": bool=?,
    ~timeout: int=?,
  ) => React.element = "Grow"
}

module Card = {
  @module("@mui/material") @react.component
  external make: (~className: string=?, ~children: React.element=?) => React.element = "Card"
}

module Table = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~className: string=?,
    ~size: string=?,
    ~aria_label: string=?,
    ~stickyHeader: bool=?,
  ) => React.element = "Table"
}

module TableCell = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~component: string=?,
    ~id: string=?,
    ~align: string=?,
    ~className: string=?,
    ~colSpan: int=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
  ) => React.element = "TableCell"
}

module TableHead = {
  @module("@mui/material") @react.component
  external make: (~children: React.element, ~className: string=?) => React.element = "TableHead"
}

module TableRow = {
  @module("@mui/material") @react.component
  external make: (~children: React.element, ~className: string=?) => React.element = "TableRow"
}

module TableContainer = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~children: React.element,
    ~component: React.element=?,
    ~className: string=?,
  ) => React.element = "TableContainer"
}

module TableBody = {
  @module("@mui/material") @react.component
  external make: (
    ~children: React.element,
    ~component: string=?,
    ~className: string=?,
  ) => React.element = "TableBody"
}

type chipSize = [#small]
module Chip = {
  @module("@mui/material") @react.component
  external make: (
    ~size: chipSize=?,
    ~label: string,
    ~className: string=?,
    ~onDelete: (ReactEvent.Mouse.t, Js.Json.t) => unit=?,
    ~onChange: ReactEvent.Form.t => unit=?,
    ~deleteIcon: React.element=?,
  ) => React.element = "Chip"
}

module Dialog = {
  @module("@mui/material") @react.component
  external make: (
    ~id: string=?,
    ~\"open": bool,
    ~onClose: unit => unit=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Dialog"
}

module DialogTitle = {
  @module("@mui/material") @react.component
  external make: (~className: string=?, ~children: React.element) => React.element = "DialogTitle"
}

module DialogContent = {
  @module("@mui/material") @react.component
  external make: (~className: string=?, ~children: React.element) => React.element = "DialogContent"
}

module DialogContentText = {
  @module("@mui/material") @react.component
  external make: (~children: React.element, ~className: string=?) => React.element =
    "DialogContentText"
}

module DialogActions = {
  @module("@mui/material") @react.component
  external make: (~className: string=?, ~children: React.element) => React.element = "DialogActions"
}

module TextField = {
  @module("@mui/material") @react.component
  external make: (
    ~className: string=?,
    ~children: React.element=?,
    ~id: string=?,
    ~value: string=?,
    ~label: string=?,
    ~variant: string=?,
  ) => React.element = "TextField"
}
