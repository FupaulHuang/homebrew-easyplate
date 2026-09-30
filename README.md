# EasyPlate Homebrew tap

This tap installs [EasyPlate](https://github.com/FupaulHuang/EasyPlate) from
its source release using Homebrew's Python. It does not download the unsigned
macOS `.pkg` installer.

## Install

Review [the formula](Formula/easyplate.rb), then run:

```bash
brew tap FupaulHuang/easyplate
brew trust --formula FupaulHuang/easyplate/easyplate
brew install FupaulHuang/easyplate/easyplate
easyplate
```

EasyPlate opens a local browser page at `http://127.0.0.1:8765`. Use
`easyplate --port 8766` to choose a different port. Keep the terminal open;
press `Ctrl+C` to stop the server. A JavaScript-enabled browser is required.

The `brew trust` command explicitly trusts this non-official formula after you
review it. Homebrew may ask for trust during installation if that step is
omitted.

## Check and update

Run `brew test FupaulHuang/easyplate/easyplate` to test the installed command.
The formula pins a source release and its SHA-256. For a new EasyPlate release,
update both values in `Formula/easyplate.rb`, test on macOS, and push the change
to this tap. The source application lives in the separate EasyPlate repository.
