open Types
open! ReactRedux

type reducers = {
  setUser: (appState, payloadAction<user>) => unit,
  setAppContext: (appState, payloadAction<appContext>) => unit,
}

type appSliceActions = {setUser: action<user>, setAppContext: action<appContext>}

let createSliceArg: createSliceArg<appState, reducers> = {
  name: "AppState",
  initialState: {
    user: Default.user,
    appContext: MerchantView("RUDRA Pvt Ltd"),
  },
  reducers: {
    setUser: (state, action: payloadAction<user>) => {
      state.user = action.payload
      LocalDB.storeUserDetails(~userDetails=state.user)
    },
    setAppContext: (state, action: payloadAction<appContext>) => {
      state.appContext = action.payload
    },
  },
}

let appSlice = createSlice(createSliceArg)

let {setUser, setAppContext} = appSlice.actions

let default = appSlice.reducer
