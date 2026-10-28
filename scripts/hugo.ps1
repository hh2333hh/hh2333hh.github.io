param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$HugoArguments
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$localHugo = Join-Path $projectRoot '.tools\hugo\hugo.exe'

if (Test-Path -LiteralPath $localHugo -PathType Leaf) {
    $hugoExecutable = $localHugo
} else {
    $installedHugo = Get-Command hugo -CommandType Application -ErrorAction SilentlyContinue
    if ($null -eq $installedHugo) {
        throw '未找到 Hugo。请安装 Hugo 0.167.0，或将 hugo.exe 放入项目的 .tools\hugo\ 目录。下载地址：https://github.com/gohugoio/hugo/releases/tag/v0.167.0'
    }
    $hugoExecutable = $installedHugo.Source
}

Push-Location -LiteralPath $projectRoot
try {
    & $hugoExecutable @HugoArguments
    if ($LASTEXITCODE -ne 0) {
        throw "Hugo 执行失败，退出码为 $LASTEXITCODE。"
    }
} finally {
    Pop-Location
}
