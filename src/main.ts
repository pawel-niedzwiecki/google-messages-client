import "./style.css";

// Insert the webview into the #app element
document.querySelector<HTMLDivElement>("#app")!.innerHTML = `
  <webview id="messageWebview" src="https://messages.google.com/web/" style="width:100%; height:100%;"></webview>
`;
