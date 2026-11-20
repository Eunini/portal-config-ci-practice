# Portal Config CI

This project uses GitHub Actions to check the settings file `app/portal-config.json` every time code is pushed.

It does not run a website and it does not deploy anything. It only checks the settings.

## What gets checked

| Setting | Rule |
|---|---|
| `appName` | Must be text and not empty |
| `environment` | Must be exactly `staging` (lower case) |
| `port` | Must be a whole number from 1024 to 65535 |
| `healthPath` | Must be text that starts with `/` |

## What's in this repo

- `app/portal-config.json`: the settings being checked
- `scripts/check-config.ps1`: the PowerShell script that checks the four rules
- `.github/workflows/ci.yml`: the GitHub Actions workflow that runs the script on a Windows runner

## How it works

1. You push a commit.
2. GitHub starts the **Portal config CI** workflow.
3. The runner gets the files and runs the check script.
4. If all four rules pass, the run is green ✅.
5. If any rule fails, the run is red ❌ and the last step is skipped.

See the results in the **Actions** tab.

## Try it: break it, then fix it

1. Open `app/portal-config.json` and change `"port": 8765` to `"port": 0`. Commit.
2. Open the **Actions** tab. The run fails with `FAIL: port must be a whole number from 1024 to 65535`.
3. Change the port back to `8765` in a **new** commit.
4. The new run passes. The failed run stays red because it belongs to the old commit.
