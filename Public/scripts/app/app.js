const defaultApp = {
  onLoad: function () { }
};

function a_app(a) {
  a = a || defaultApp;

  window.onload = () => { (a.onLoad || defaultApp.onLoad)(a) };
  return a;
};

export { a_app };