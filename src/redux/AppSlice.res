open Types
open! ReactRedux

type reducers = {setUser: (appState, payloadAction<user>) => unit}

let createSliceArg: createSliceArg<appState, reducers> = {
  name: "AppState",
  initialState: {
    user: Default.user,
  },
  reducers: {
    setUser: (state, action: payloadAction<user>) => {
      state.user = action.payload
      LocalDB.storeUserDetails(~userDetails=state.user)
    },
  },
}

let appSlice = createSlice(createSliceArg)

let default = appSlice.reducer
