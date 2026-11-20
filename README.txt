PORTAL CONFIG CI — CLASS 2
This project checks four rules in app/portal-config.json.
It is not a web server and does not deploy an app.

RULES
appName: non-empty text.
environment: exactly staging, in lower case, for this practice project.
port: a JSON whole number from 1024 to 65535, including both ends.
healthPath: text starting with /.

CLASS SETUP
Keep app/ and scripts/ at the top of your practice Git repository.
Create .github/workflows/ci.yml in that same repository.
Copy its contents from the supplied templates/ci-workflow.txt.
The workflow uses a standard GitHub-hosted Windows runner with PowerShell.
The template is outside this starter folder so no workflow is added until the class step.

DELIBERATE CLASS FAULT
Change port from 8765 to 0, commit and push.
Expected: port check fails and the confirm step is skipped.
Restore 8765 in a NEW commit and push.
Expected: all four rules pass for that new commit.

OPTIONAL LOCAL CHECK
If script execution is already allowed on your Windows setup:
  powershell -NoProfile -File .\scripts\check-config.ps1
Or with an existing PowerShell 7 installation:
  pwsh -NoProfile -File .\scripts\check-config.ps1
Do not change device policy to do this. Local execution is not required for GitHub Actions.

Never put passwords or access tokens in this project or its evidence files.
