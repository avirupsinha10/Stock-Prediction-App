@react.component
let make = (~toastContent: string) => {
  <div className="floating-toast-modal">
    <div className="toast-container">
      <div className="circular-loader">
        <div className="circle1">
          <div className="circle2">
            <div className="circle3"> <div className="circle4" /> </div>
          </div>
        </div>
      </div>
      <div className="toast-body"> {React.string(toastContent)} </div>
    </div>
  </div>
}
