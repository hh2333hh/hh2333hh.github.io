param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Title,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z0-9]+(?:-[a-z0-9]+)*$')]
    [string]$Slug
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($Title)) {
    throw '文章标题不能为空。'
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$postDirectory = Join-Path $projectRoot "content\posts\$Slug"
if (Test-Path -LiteralPath $postDirectory) {
    throw "文章目录已存在，未覆盖：$postDirectory"
}

$previousTitle = [Environment]::GetEnvironmentVariable('HUGO_NEW_POST_TITLE', 'Process')
try {
    [Environment]::SetEnvironmentVariable('HUGO_NEW_POST_TITLE', $Title.Trim(), 'Process')
    & (Join-Path $PSScriptRoot 'hugo.ps1') new content "posts/$Slug/index.md" --kind posts
} finally {
    [Environment]::SetEnvironmentVariable('HUGO_NEW_POST_TITLE', $previousTitle, 'Process')
}

Write-Output "文章已创建：$postDirectory\index.md"
Write-Output '写好后，将文章开头的 draft: true 改为 draft: false 即可发布。'
