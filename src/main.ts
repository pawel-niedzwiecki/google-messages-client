import "./style.css";

// Insert the webview into the #app element
document.querySelector<HTMLDivElement>("#app")!.innerHTML = `
  <webview id="messageWebview" src="https://messages.google.com/web/" style="width:100%; height:100%;"></webview>
`;

// Cast the element to Electron.WebviewTag
const webview = document.getElementById(
  "messageWebview"
) as Electron.WebviewTag;

if (webview) {
  webview.addEventListener("dom-ready", () => {
    // Send a message to the webview (requires corresponding listener in the webview context)
    webview.send("some-channel", { data: "Hello from main app" });
  });
}

// Listen for messages from the webview (if using postMessage)
window.addEventListener("message", (event) => {
  console.log("Received message:", event.data);
});
