type enhancedStore
type sliceReducer

type payloadAction<'t> = {payload: 't}
type rootState = {app: Types.appState}

@module("react-redux")
external useSelector: (rootState => 'a) => 'a = "useSelector"

type actionType
type action<'input> = (. 'input) => actionType

type dispatch = actionType => unit

@module("react-redux")
external useDispatch: unit => dispatch = "useDispatch"

type slice<'sliceActions> = {
  actions: 'sliceActions,
  reducer: sliceReducer,
}

type createSliceArg<'sliceState, 'reducers> = {
  name: string,
  initialState: 'sliceState,
  reducers: 'reducers,
}

@module("@reduxjs/toolkit")
external createSlice: createSliceArg<'sliceState, 'reducers> => slice<'sliceActions> = "createSlice"

module Provider = {
  @module("react-redux") @react.component
  external make: (~store: enhancedStore, ~children: React.element) => React.element = "Provider"
}
