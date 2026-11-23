# Images

Screenshots live in `img/src/<lang>/<name>.jpg` (EN and TR sources are separate).

To replace a screenshot: overwrite the file in `img/src/en/` and `img/src/tr/`
with a new 1600x900 JPG, keeping the name.

Then run `tools/images.sh`. It writes the 960/1920 webp files and the 1600 JPG
to `img/<lang>/`.

`qr-login.mp4` / `qr-login.webm` are videos, not screenshots. Make them with
`tools/brand/qr-demo.sh en|tr` in the app repo, then copy them plus
`qr-login-poster.jpg` into `img/src/<lang>/` and run `tools/images.sh`.
