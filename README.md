# Claude Plugin Versioning Guide

This plugin uses a versioned release flow so Claude Code can detect updates whenever the plugin content changes.

## Why versioning matters

Claude Code checks the plugin version before deciding whether a plugin update is needed. If the version string does not change, Claude may keep using the old cached copy even when the GitHub repository has new content.

For this plugin, the version is stored in:

- `.claude-plugin/plugin.json`

## Required rule

Whenever you change any plugin content, such as:

- `skills/SKILL.md`
- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

you must increase the plugin version before pushing.

## Manual version bump

Run this command from the project root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bump-plugin-version.ps1
```

This increments the patch version.

Example:

- `1.0.0` -> `1.0.1`
- `1.0.1` -> `1.0.2`

## Commit and push

```powershell
git add .
git commit -m "Update building plugin"
git push
```

## Update plugin in Claude

Run the following in Claude Code or the terminal where `claude` is available:

```powershell
claude plugin marketplace update my-plugins-marketplace
claude plugin update building@my-plugins-marketplace
```

Inside Claude Code:

```text
/plugin marketplace update my-plugins-marketplace
/plugin update building@my-plugins-marketplace
/reload-plugins
```

## Automatic version bump on push

This repository includes a GitHub Actions workflow that bumps the version automatically on every push to `main`:

- `.github/workflows/claude-plugin-version-bump.yml`

The workflow will:

1. read `.claude-plugin/plugin.json`
2. increment the patch version
3. commit the change
4. push it back to the repository

## If Claude still shows the old version

Sometimes the old cached plugin remains on Windows. In that case, clear the plugin cache and reinstall:

```powershell
Get-Process | Where-Object { $_.ProcessName -match 'claude|node' } | Stop-Process -Force -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:USERPROFILE\.copilot\installed-plugins\my-plugins-marketplace" -ErrorAction SilentlyContinue
claude plugin install building@my-plugins-marketplace
```

Then run:

```powershell
claude plugin marketplace update my-plugins-marketplace
claude plugin update building@my-plugins-marketplace
```

## Simple rule to follow

Always do this before pushing a plugin change:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\bump-plugin-version.ps1
```

and then commit and push.
