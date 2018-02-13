Import-Module PSReadLine
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -MaximumHistoryCount 4000
# history substring search
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
# Tab completion
Set-PSReadlineKeyHandler -Chord 'Shift+Tab' -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

Import-Module Get-ChildItemColor

Set-Alias ls Get-ChildItemColor -option AllScope
Set-Alias l Get-ChildItemColorFormatWide -option AllScope

Import-Module z
Import-Module posh-git
Import-Module posh-docker
# Use this file to run your own startup commands

# Configure prompt
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    $Host.UI.RawUI.ForegroundColor = "White"

    $time = (Get-Date -Format HH:mm:ss).Trim() + " "

    Write-Host $time -NoNewLine -ForegroundColor Gray

    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Red
    Write-Host " at " -NoNewline -ForegroundColor Gray

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower())) {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewLine -ForegroundColor "DarkBlue"

    if ($GitStatus) {
        Write-Host ""$(git config user.email) -NoNewLine -ForegroundColor DarkYellow
    }

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-Host "`n>" -NoNewLine -ForegroundColor "Green"

    return " "
}

# Personalize poshgit
# https://github.com/dahlbyk/posh-git/blob/2faae5deb04393879ab60760256f8fd240eb4a59/GitPrompt.ps1
$GitPromptSettings.LocalWorkingStatusSymbol = '!'
$GitPromptSettings.BeforeText = ' on '
$GitPromptSettings.AfterText = ''
$GitPromptSettings.BeforeForegroundColor = $GitPromptSettings.AfterForegroundColor = [ConsoleColor]::Gray
$GitPromptSettings.BranchIdenticalStatusToForegroundColor = [ConsoleColor]::DarkGreen

    # ------------ Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}