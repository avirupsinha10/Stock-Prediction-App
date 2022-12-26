module LocalStore = {
  type localStorage
  @val
  external localStorage: localStorage = "window.localStorage"
  @send
  external getItem: (localStorage, string) => Js.Null_undefined.t<string> = "getItem"
  @send
  external setItem: (localStorage, string, string) => unit = "setItem"
  @send
  external removeItem: (localStorage, string) => unit = "removeItem"
  @send
  external clear: localStorage => unit = "clear"
  @get
  external length: localStorage => int = "length"
}

module DomUtil = {
  @send
  external getElementById: (Dom.document, string) => Js.Nullable.t<Dom.element> = "getElementById"

  @send
  external removeChild: (Dom.element, Dom.element) => unit = "removeChild"

  external elemAsObj: Dom.element => {..} = "%identity"
  let setStyle = (base: Dom.element, style: {..}) => (base->elemAsObj)["style"] = style

  let findAndSetStyle = (~id, ~property, ~value) =>
    Webapi.Dom.document
    ->Webapi.Dom.Document.getElementById(id)
    ->Belt.Option.flatMap(Webapi.Dom.Element.asHtmlElement)
    ->Belt.Option.mapWithDefault((), ele =>
      ele
      ->Webapi.Dom.HtmlElement.style
      ->Webapi.Dom.CssStyleDeclaration.setProperty(property, value, "important")
    )

  let hideLoadShimmer = () => {
    switch Webapi.Dom.document->Webapi.Dom.Document.getElementById("onboarding-start-loader") {
    | Some(elem) => {
        elem->setStyle({"display": "none"})
        switch Webapi.Dom.document
        ->Webapi.Dom.Document.asHtmlDocument
        ->Belt.Option.flatMap(Webapi.Dom.HtmlDocument.body) {
        | Some(body) =>
          body->removeChild(elem)
          findAndSetStyle(~id="app", ~property="display", ~value="block")
        | None => ()
        }
      }
    | None => ()
    }
  }

  // let showLoadShimmer = (~flowShimmer) => {
  //   let child = Webapi.Dom.Document.createElement(Webapi.Dom.document, "div")
  //   child->Webapi.Dom.Element.setId("onboarding-start-loader")
  //   child->Webapi.Dom.Element.setInnerHTML(
  //     flowShimmer
  //       ? `<div class="shimmer-loader header_shimmer"></div>

  //     <div class="shimmer-loader desc_shimmer"></div>

  //     <div class="shimmer-loader flow_shimmer"></div>`
  //       : `<div class="shimmer-loader searchbar_shimmer"></div>

  //       <div class="shimmer-loader taskbar1_shimmer"></div>

  //     <div class="shimmer-loader taskbar2_shimmer"></div>

  //     <div class="shimmer-loader flow_shimmer"></div>`,
  //   )
  //   Webapi.Dom.document
  //   ->Webapi.Dom.Document.asHtmlDocument
  //   ->Belt.Option.flatMap(Webapi.Dom.HtmlDocument.body)
  //   ->Belt.Option.mapWithDefault((), Webapi.Dom.Element.appendChild(~child))
  //   findAndSetStyle(~id="app", ~property="display", ~value="none")
  // }
}

module External = {
  external treatAsJson: 'a => Js.Json.t = "%identity"
  external treatAsAny: 'a => 'b = "%identity"
  external treatAsString: 'a => string = "%identity"
  external identity: 'a => 'b = "%identity"

  type authData = {token: string, theme: string}
  @val external authData: authData = "window.__authData"

  @val external scope: Types.environment = "SCOPE"
  @val external workInProgress: string = "WORK_IN_PROGRESS"
  @val external turingUrl: string = "TURING_URL"
  @val external internalTeamList: array<string> = "INTERNAL_TEAM_LIST"
  @val external managerList: array<string> = "MANAGER_EMAIL_LIST"
  @val external developerList: array<string> = "DEVELOPER_EMAIL_LIST"
  @val external adminList: array<string> = "ADMIN_EMAIL_LIST"
  @val external hotjarId: string = "HOTJAR_ID"
  @val external freshDeskId: string = "FRESHDESK_ID"
  @val external mixPanelId: string = "MIXPANEL_ID"
  @val external filterFeature: string = "FILTER_FEATURE"

  // let getUserRole = (userEmail: string): Types.userRole => {
  //   if internalTeamList->Js.Array2.includes(userEmail) {
  //     #INTERNAL_TEAM
  //   } else if managerList->Js.Array2.includes(userEmail) {
  //     #MANAGER
  //   } else if developerList->Js.Array2.includes(userEmail) {
  //     #DEVELOPER
  //   } else if adminList->Js.Array2.includes(userEmail) {
  //     #ADMIN
  //   } else {
  //     #USER
  //   }
  // }

  // let isInternalTeamAndAbove = (userRole: Types.userRole) =>
  //   userRole == #INTERNAL_TEAM ||
  //   userRole == #MANAGER ||
  //   userRole == #DEVELOPER ||
  //   userRole == #ADMIN

  // let isManagerAndAbove = (userRole: Types.userRole) =>
  //   userRole == #MANAGER || userRole == #DEVELOPER || userRole == #ADMIN

  // let isDeveloperAndAbove = (userRole: Types.userRole) =>
  //   userRole == #DEVELOPER || userRole == #ADMIN

  // let isAdmin = (userRole: Types.userRole) => userRole == #ADMIN
}
