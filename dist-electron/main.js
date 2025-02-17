import { app as n, BrowserWindow as t, nativeImage as p } from "electron";
import { fileURLToPath as d } from "node:url";
import o from "node:path";
const s = o.dirname(d(import.meta.url));
process.env.APP_ROOT = o.join(s, "..");
const i = process.env.VITE_DEV_SERVER_URL, w = o.join(process.env.APP_ROOT, "dist-electron"), r = o.join(process.env.APP_ROOT, "dist");
process.env.VITE_PUBLIC = i ? o.join(process.env.APP_ROOT, "public") : r;
let e;
function a() {
  const c = o.join(process.env.VITE_PUBLIC, "icon.icns"), l = p.createFromPath(c);
  e = new t({
    icon: l,
    webPreferences: {
      webviewTag: !0,
      preload: o.join(s, "preload.mjs")
    }
  }), e.webContents.on("did-finish-load", () => {
    e == null || e.webContents.send("main-process-message", (/* @__PURE__ */ new Date()).toLocaleString());
  }), i ? e.loadURL(i) : e.loadFile(o.join(r, "index.html"));
}
n.on("window-all-closed", () => {
  process.platform !== "darwin" && (n.quit(), e = null);
});
n.on("activate", () => {
  t.getAllWindows().length === 0 && a();
});
n.whenReady().then(a);
export {
  w as MAIN_DIST,
  r as RENDERER_DIST,
  i as VITE_DEV_SERVER_URL
};
