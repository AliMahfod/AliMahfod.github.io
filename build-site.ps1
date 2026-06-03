Set-Location $PSScriptRoot\source
& "$PSScriptRoot\.venv\Scripts\mkdocs.exe" build -d ..\docs
New-Item -Path "$PSScriptRoot\docs\.nojekyll" -ItemType File -Force | Out-Null
