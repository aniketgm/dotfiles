#              __________________ 
#          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
#         /  \  \  \         __/  /  \  /  \          Description : This is a powershell configuration file
#        /    \  \       _____   /    \/    \                       similar to the .bashrc for bash. This runs
#       /  /\  \  \     /    /  /            \                      before the powershell prompt and contains
#      /        \  \        /  /      \/      \                     configurations of Aliases, Functions, etc..
#     /          \  \      /  /                \
#    /            \  \    /  /                  \
#   /              \  \  /  /                    \
#  /__            __\  \/  /__                  __\
#

# Variables
# ---------
# $Env:HOME = $Env:USERPROFILE
# $SHELL = 'pwsh'
$Env:EDITOR = "nvim"      # For default editor as nvim
$Env:DFT_COLOR = "always" # For difftastic to enable colors when piped
$ErrorActionPreference = 'Ignore'

# Set Theme
# ---------
If (Get-Command oh-my-posh)
{
  $LikedThemeFiles = @(
    'bubblesextra', 'bubblesline',
    'catppuccin',
    'hotstick.minimal',
    'marcduiker', 'marcduiker_custom'
  )
  $OMPThemeFile = $LikedThemeFiles[5] + '.omp.json'
  oh-my-posh init pwsh --config "$Env:POSH_THEMES_PATH\$OMPThemeFile" | Invoke-Expression
}
Else
{
  Write-Output "To have a wonderful powershell experience, it is recommended to have 'oh-my-posh' installed."
  Write-Output "This message will appear for every powershell launch. To remove it delete this from the powershell profile"
}



# Essential tools check
# ---------------------
If (Get-Command fzf) {
  $Env:FZF_DEFAULT_OPTS = `
    "--border=rounded --reverse --history=C:\\Users\\$Env:USERNAME\\.fzf_history --bind shift-up:preview-half-page-up,shift-down:preview-half-page-down"
}
Else { Write-Output "Note: required tool 'fzf' missing. If you have scoop: scoop install fzf, Else: winget install fzf"}
If (Get-Command fd) {} Else { Write-Output "Note: required tool 'fd' missing. If you have scoop: scoop install fd, Else: winget install fd"}
If (Get-Command rg) {} Else { Write-Output "Note: required tool 'rg' missing. If you have scoop: scoop install rg, Else: winget install rg"}

# Functions and Filters
# ---------------------
function .. { Set-Location .. }
function ~ { Set-Location $Env:USERPROFILE }
function assoc { CMD /C "assoc $Args" }
function ftype { CMD /C "ftype $Args" }
function fa { Get-Alias | Select-Object Name,Definition | Format-Table -HideTableHeaders | fzf --height=20 --prompt="Alias  " }
function gca($CmdName) { (Get-Command $CmdName).Parameters.Values | Select-Object Name, Aliases }
function la { Get-ChildItem -Hidden $Args }
function lse { Get-ChildItem $Args | Sort Extension }
function lsl { Get-ChildItem $Args | Where-Object { $_.LinkType -eq 'SymbolicLink' } }
function lsw { Get-ChildItem $Args | Format-Wide -AutoSize }
function mcd { Set-Location (mkdir $Args) }
function nf { New-Item -Path $Args -ItemType File }
function phead([Int]$Lines=10) { $Input | Select-Object -First $Lines }
function ptail([Int]$Lines=10) { $Input | Select-Object -Last $Lines }
function q { exit }
function rmr { Remove-Item -Recurse -Verbose -Force $Args }
function sshm { ssh -m hmac-sha2-512 $Args }
function which($Cmd) { Get-Command $Cmd -ErrorAction Ignore | Select-Object -ExpandProperty Path -ErrorAction Ignore }

## Activate virtual env in a python project
function activate($ProjFolder=(Resolve-Path . -Relative))
{
  If (Get-Command oh-my-posh -ErrorAction Ignore) { $Env:VIRTUAL_ENV_DISABLE_PROMPT=1 }
  # If (Test-Path $ProjFolder\"$((Get-Item *env*).Name)")
  If (Test-Path "$ProjFolder\venv")
  {
    & "$ProjFolder\venv\Scripts\Activate.ps1"
  }
  Else { Write-Output "Goto the python project root folder and then run this command ..." }
}

# Compare folders
#function cmpfold([String]$FolderScope=".")
#{
#  $RefFolder = (fd . "$FolderScope" --type d --hidden --no-ignore --ignore-case `
#    | fzf --header="Search ref folder to compare" --height=25)
#  If ($RefFolder)
#  {
#    $DiffFolder = (fd . "$FolderScope" --type d --hidden --no-ignore --ignore-case `
#      | fzf --header="Search diff folder to compare" --height=25)
#    If ($DiffFolder)
#    {
#      $RefFoldList = (Get-ChildItem -Recurse -Path $RefFolder | ForEach-Object {Resolve-Path $_ -Relative})
#      $DiffFoldList = (Get-ChildItem -Recurse -Path $DiffFolder | ForEach-Object {Resolve-Path $_ -Relative})
#      Write-Output "Left  (Compare): $RefFolder"
#      Write-Output "Right (With):    $DiffFolder"
#      Compare-Object -ReferenceObject $RefFoldList -DifferenceObject $DiffFoldList
#    }
#  }
#}

# Search and jump to a folder
function fcd($FolderScope=".", [Switch]$GitDirs)
{
  If ($FolderScope -eq '~') { $FolderScope = $HOME }
  If ($GitDirs.IsPresent)
  {
    $FZF_OUTPUT = (fd -t d --hidden --no-ignore --max-depth 4 --prune "\.git$" $FolderScope `
      | Split-Path | fzf --preview="eza --color=always --icons --group-directories-first -l {}" `
                         --prompt=" Git Repo  " --height=25)
  }
  Else
  {
    $FZF_OUTPUT = (fd -t d . "$FolderScope" `
      | fzf --preview="eza --color=always --icons --group-directories-first -l {}" `
            --prompt="Jump to Folder  " --height=20)
  }
  If ($FZF_OUTPUT)
  {
    If (Get-Command zoxide -ErrorAction Ignore) { z $FZF_OUTPUT }
    Else { Set-Location $FZF_OUTPUT }
  }
}

# Copy file(s) to destination
function fcp([Switch]$Move, [Switch]$RecurseCopy, $SearchFolder='.', $DestScope='.')
{

  $FZF_DATATOCOPY = (fd --type $(If ($RecurseCopy.IsPresent) {'d'} Else {'f'}) --no-ignore --ignore-case . $SearchFolder | `
                    fzf --prompt="זּ Copy Data  " --multi --height=20 --cycle)
  Write-Output $FZF_DATATOCOPY
  If ($FZF_DATATOCOPY)
  {
    $FZF_DESTFOLD = (fd --type d . "$DestScope" | `
                     fzf --prompt="ﯺ Destination Folder  " --height=20 --cycle)
    If ($FZF_DESTFOLD) {
      If ($Move.IsPresent)
      {
        $FZF_DATATOCOPY | ForEach-Object {
          $FileToMove = ($_ -replace '\[','`[') -replace '\]','`]'
          Move-Item -Verbose "$FileToMove" "$FZF_DESTFOLD"
        }
      }
      ElseIf ($RecurseCopy.IsPresent)
      {
        $FZF_DATATOCOPY | ForEach-Object {
          $FolderToCopy = ($_ -replace '\[','`[') -replace '\]','`]'
          Copy-Item -Verbose -Recurse "$FolderToCopy" "$FZF_DESTFOLD"
        }
      }
      Else
      {
        $FZF_DATATOCOPY | ForEach-Object {
          $FileToCopy = ($_ -replace '\[','`[') -replace '\]','`]'
          Copy-Item -Verbose "$FileToCopy" "$FZF_DESTFOLD"
        }
      }
    }
  }
}

# Print function definitions on console
function ffn([Switch]$SyntaxHelp)
{
  $FuncName = Get-ChildItem Function: | Select-Object Name | Format-Table -HideTableHeaders | fzf --height=20 --prompt="⨐ PS Functions  "
  If ($FuncName)
  {
    If ($SyntaxHelp.IsPresent) { Get-Command $FuncName -Syntax }
    Else { (Get-ChildItem Function:$FuncName | Select-Object Definition).Definition | bat --language=powershell --plain --number }
  }
}

## Filter for formatting file size from Bytes to KB, MB, GB, etc.
filter ffs
{
  If     ($_ -gt 1TB) {[string]::Format("{0:0.0}T", $_ / 1TB)}
  ElseIf ($_ -gt 1GB) {[string]::Format("{0:0.0}G", $_ / 1GB)}
  ElseIf ($_ -gt 1MB) {[string]::Format("{0:0.0}M", $_ / 1MB)}
  ElseIf ($_ -gt 1KB) {[string]::Format("{0:0.0}K", $_ / 1KB)}
  ElseIf ($_ -ge 0)   {[string]::Format("{0:0}",    $_)}
  Else                {""}
}

# Get/Run history commands
function fh([Switch]$Run)
{
  $HistContRev = (hist)
  [Array]::Reverse( $HistContRev )
  $HistorySelected = ($HistContRev | fzf --height=20 --prompt="Command History  ")
  If ($HistorySelected)
  {
    If ($Run.IsPresent) { Invoke-Expression ($HistorySelected) }
    Else { $HistorySelected | clip; Write-Output "Copied to clipboard" }
  }
}

# Make directory anywhere 
function fmd
{
  Param(
    [Parameter(Mandatory=$True, Position=0)][String]$FolderName,
    [Parameter(Position=1)][String]$DestScope="$HOME"
  )
  If ($DestScope -eq ".") { mkdir $FolderName }
  Else
  {
    $Local:DestFolder = (fd -t d . $DestScope | fzf --prompt="Destination Folder  " --cycle --height=25)
    If ($DestFolder) { mkdir $DestFolder\$FolderName }
  }
}

# Open files like PDF, DOCX, etc..
function fo
{
  Param(
    [Switch]$OneDrive,
    [Switch]$Editable,
    [Switch]$ViewOnly,
    $SearchFolder='.'
  )
  If ($OneDrive.IsPresent)
  {
    Push-Location "$HOME\OneDrive - Ensono"
    $FZF_OUTPUT = (fd . . --type f --hidden --no-ignore --ignore-case `
      | fzf --prompt="📂 OneDrive  " --height=25 --delimiter '\' --with-nth -2,-1)
    If ($FZF_OUTPUT) { & "$FZF_OUTPUT" }
    Pop-Location
  }
  ElseIf ($Editable.IsPresent)
  {
    $FZF_OUTPUT = (fd . $SearchFolder --type f --hidden --no-ignore --ignore-case `
      | fzf --preview="bat --color=always --style=numbers {}" `
            --prompt="📝 Edit File  " --height=25)
    If ($FZF_OUTPUT)
    {
      If ($ViewOnly.IsPresent) { b $FZF_OUTPUT }
      Else { v '$FZF_OUTPUT' }
    }
  }
  Else
  {
    $FZF_OUTPUT = (fd . $SearchFolder --type f --hidden --no-ignore --ignore-case `
      | fzf --prompt="📃 Open File  " --height=25)
    If ($FZF_OUTPUT) { & "$FZF_OUTPUT" }
  }
}

# Get list of fonts installed
function fonts
{
  $Temp = [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
  $FontName = ((New-Object System.Drawing.Text.InstalledFontCollection).Families | Select-Object Name -ExpandProperty Name `
                  | fzf --height=20 --prompt="Search Font  ")
  If ($FontName) { $FontName | clip; Write-Output "Copied to clipboard" }
}

# Delete files under a folder
function frm($SearchFolder, [Switch]$Recurse)
{
  $FZF_DELFILES = ""
  If ($Recurse.IsPresent)
  {
    $FZF_DELFILES = (fd . $SearchFolder --type d --hidden --no-ignore --ignore-case `
      | fzf --preview="eza --color=always --icons --group-directories-first -lr -s size {}" `
            --prompt="💀 Delete Folders  " --height=25 --keep-right --preview-window="right:60%")
    If ($FZF_DELFILES -And (@('Y','y') -contains (Read-Host "CAREFUL you're about to delete a folder and all it's contents. Proceed ? (y/n)")))
    {
      $FZF_DELFILES | ForEach-Object { Remove-Item -Verbose -Recurse "$_" -Force }
    }
  }
  Else
  {
    $FZF_DELFILES = (fd . $SearchFolder --type f --hidden --no-ignore --ignore-case `
      | fzf --preview="bat --color=always --style=numbers {}" `
            --prompt="💀 Delete Files (BE CAREFUL)  " --multi --height=25)
    If ($FZF_DELFILES) { $FZF_DELFILES | ForEach-Object { Remove-Item -Verbose "$_" } }
  }
}

# History saved by PSReadline
function hist([Switch]$ShowPath, [Switch]$Count)
{
  $HistoryPath = (Get-PSReadLineOption).HistorySavePath 
  If ($ShowPath.IsPresent) { Write-Output $HistoryPath }
  ElseIf ($Count.IsPresent) { (Get-Content $HistoryPath | Measure-Object -Line).Lines }
  Else { Get-Content $HistoryPath }
}

## Edit Module Code
function modloc([String]$ModuleName)
{
  If ([String]::IsNullOrEmpty($ModuleName))
  {
    Write-Output "Pass a module name. Pressing tab after the command will cycle through the installed modules"
    Return 
  }
  Return (Get-Module $ModuleName).ModuleBase
}

## Auto-complete powershell modules for modloc command
Register-ArgumentCompleter -CommandName modloc -ScriptBlock { (Get-Module).Name }

# Note taking system
function note
{
  Param (
    [Switch]$SearchNotes,
    [String]$LinesPrint,
    [Switch]$Today,
    [Switch]$Yesterday,
    [Switch]$MyPersnl,
    [Switch]$ObsidianOpen,
    [String]$NewNote
  )
  $ObsidianPath = "$HOME\Documents\obsidiannotes"
  $Dailies = "$ObsidianPath\Work\Dailies"
  If ($MyPersnl.IsPresent)
  {
    Push-Location "$ObsidianPath\Personal"
    $Local:ViewNotesOP = (fd -t f -e md | fzf --preview="bat --color=always --style=numbers {}" `
                             --prompt="📖 Edit Note  " --cycle --delimiter '\' --with-nth -2,-1 `
                             --height=25 --preview-window="right:65%,border-rounded")
    If ($ViewNotesOP) { v "$ViewNotesOP" }
    Pop-Location
  }
  Else
  {
    If ($ObsidianOpen.IsPresent) { & "$Env:LOCALAPPDATA\Obsidian\Obsidian.exe" }
    ElseIf ($Today.IsPresent)
    {
      $TodaysDate = "$(Get-Date -Format 'yyyy-MMM-dd')"
      $TodaysDateFile = $TodaysDate + ".md"
      If (Test-Path $Dailies\$TodaysDateFile -PathType Leaf) { v $Dailies\$TodaysDateFile }
      Else {
        Write-Output "Creating today's daily note.."
        nvim -c 'edit ~/Documents/obsidiannotes/Work/Misc/tasks-done.md' -c 'bd1' -c 'ObsidianToday'
      }
    }
    ElseIf ($SearchNotes.IsPresent)
    {
      Push-Location "$Dailies\.."
      $Local:ViewNotesOP = (rg "" --line-number --no-heading . | `
                            fzf --cycle --prompt="🔍 RGrep Notes  " --height=25)
      $Local:ViewNotesFile = ($ViewNotesOP -split ':')[0]
      $Local:ViewNotesLineNo = ($ViewNotesOP -split ':')[1]
      If ($ViewNotesOP)
      {
        If ($LinesPrint)
        {
          $PreLines = 0
          $PostLines = 0
          If ($LinesPrint[0] -eq '+') { $PostLines = [Int]$LinesPrint.Substring(1) }
          ElseIf ($LinesPrint[0] -eq '-') { $PreLines = [Int]$LinesPrint.Substring(1) }
          Else { $PreLines = [Int]$LinesPrint; $PostLines = [Int]$LinesPrint }
          $NotesLineNo = [Int]$ViewNotesLineNo
          bat "$ViewNotesFile" --color=always --style=numbers --line-range "$($NotesLineNo - $PreLines):$($NotesLineNo + $PostLines)"
        }
        Else { v "$ViewNotesFile" +$ViewNotesLineNo }
      }
      Pop-Location
    }
    ElseIf (-Not [String]::IsNullOrEmpty($NewNote))
    {
      Push-Location "$Dailies\.."
      $Local:ViewNotesFolders = (fd -t d . "$HOME\Documents\obsidiannotes\Work" | `
                                 fzf --cycle --prompt="📑 Create Note  " --height=25)
      If ($ViewNotesFolders) { nf $ViewNotesFolders\$NewNote }
      Pop-Location
    }
    Else
    {
      Push-Location "$Dailies\.."
      $Local:ViewNotesOP = (fd -t f -e md | fzf --preview="bat --color=always --style=numbers {}" `
                               --prompt="📖 Open Note  " --cycle --delimiter '\' --with-nth -2,-1 `
                               --height=25 --preview-window="right:65%,border-rounded")
      If ($ViewNotesOP) { v "$ViewNotesOP" }
      Pop-Location
    }
  }
}

function nvs
{
  $Items = @("default", "kickstart")
  $Config = $Items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0

  If ([string]::IsNullOrEmpty($Config)) { Write-Output "Nothing selected"; Break }
  If ($Config -eq "default") { $Config = "" }

  $Env:NVIM_APPNAME=$Config
  nvim $Args
}

## Start new office application
function ofc([Switch]$Ppt, [Switch]$Visio, [Switch]$Word, [Switch]$Xcel)
{
  If ($Ppt.IsPresent)   { Start-Process powerpnt }
  If ($Visio.IsPresent) { Start-Process visio }
  If ($Word.IsPresent)  { Start-Process winword }
  If ($Xcel.IsPresent)  { Start-Process excel }
}

## Powershell Disk Usage
function psdu([String]$PathName=".")
{
  $DUScriptBlk = {
    Param ([String]$PathName)

    Begin
    {
      filter ffs
      {
        If     ($_ -gt 1TB) {[string]::Format("{0:0.0}T", $_ / 1TB)}
        ElseIf ($_ -gt 1GB) {[string]::Format("{0:0.0}G", $_ / 1GB)}
        ElseIf ($_ -gt 1MB) {[string]::Format("{0:0.0}M", $_ / 1MB)}
        ElseIf ($_ -gt 1KB) {[string]::Format("{0:0.0}K", $_ / 1KB)}
        ElseIf ($_ -ge 0)   {[string]::Format("{0:0}",    $_)}
        Else                   {""}
      }
    }

    Process
    {
      $AllOutput = $DirOutput = $FilOutput = @()
      $TotalSize = 0

      # Recursively walk through the folders and get size for each
      Get-ChildItem $PathName -Directory | ForEach-Object {
        $Output = [PSCustomObject]@{
          ContentName = "$($_.Name)/"
          SizeOnDisk  = $(
            $Tmp = (Get-ChildItem -LiteralPath $_.FullName -Recurse -ErrorAction SilentlyContinue `
                   | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
            If ([String]::IsNullOrEmpty($Tmp)) { 0 }
            Else { $Tmp }
          )
        }
        $DirOutput += $Output
        $TotalSize += $Output.SizeOnDisk
      }
      $AllOutput += ($DirOutput | Sort-Object -Property SizeOnDisk -Descending)

      # Files in the current directory are ingnored. Get sizes of this as well.
      Get-ChildItem $PathName -File | ForEach-Object {
        $Output = [PSCustomObject]@{
          ContentName = $_.Name
          SizeOnDisk  = (Get-ChildItem $_.FullName -ErrorAction SilentlyContinue `
                        | Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
        }
        $FilOutput += $Output
        $TotalSize += $Output.SizeOnDisk
      }
      $AllOutput += ($FilOutput | Sort-Object -Property SizeOnDisk -Descending)

      Write-Output "`n## Total Size : $( $TotalSize | ffs )"
      If ($OnlyTotal) { Exit; }
      $AllOutput | Format-Table @{Label="Size";     Expression={ $_.SizeOnDisk | ffs }},
                                @{Label="Contents"; Expression={ $_.ContentName }}
    }
  }
  spinner -ScriptToExec $DUScriptBlk -Label "Calculating size ..." -OtherArgs (Get-Item $PathName).FullName
}

# Put computer to sleep (not hibernate)
function slc
{
  Add-Type -Assembly System.Windows.Forms
  $SleepTmp = [System.Windows.Forms.Application]::SetSuspendState("Suspend", $false, $true)
}

## Spinner. Cyles through -- [ '|',  '/', '-', '\' ]
function spinner([Scriptblock]$ScriptToExec, [String]$Label, [String]$OtherArgs)
{
  $job = Start-Job -ScriptBlock $ScriptToExec -ArgumentList $OtherArgs
  $symbols = @("|", "/", "-", "\")
  $TimerWatch = [System.Diagnostics.Stopwatch]::StartNew()
  $WaitMessage = "[may take some time ...]"
  $i = 0
  while ($job.State -eq "Running")
  {
    $symbol =  $symbols[$i]
    Write-Host -NoNewLine "`r$symbol $Label $(If ($TimerWatch.Elapsed.Seconds -gt 30) { $WaitMessage } )" -ForegroundColor Green
    Start-Sleep -Milliseconds 100
    $i += 1
    if ($i -eq $symbols.Count) { $i = 0 }
  }
  Write-Host -NoNewLine "`r"
  If ($job.State -eq 'Failed') { Write-Output ($job.ChildJobs[0].JobStateInfo.Reason.Message) }
  Else
  {
    $JobOutput = Receive-Job -Job $job 6>&1
    Write-Output $JobOutput | more
  }
}

## UTF conversion
function U
{
  Param([Int]$Code)
  If ((0 -le $Code) -and ($Code -le 0xFFFF)) { return [char] $Code }
  If ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) { return [char]::ConvertFromUtf32($Code) }
  throw "Invalid character code $Code"
}

# Launch lunarvim/nvim
function v
{
  $LvimLauncher = "$HOME\.local\bin\lvim.ps1"
  If(Test-Path -Path $LvimLauncher -PathType Leaf) { Invoke-Expression "& $LvimLauncher $Args" }
  Else { nvim $Args }
}

# Open editor inside dotfiles repo
function vd([Switch]$NvimConfLoc, [Switch]$WeztermConfLoc, [Switch]$PSProfileLoc)
{
  If ($NvimConfLoc.IsPresent) { Return "$Env:LOCALAPPDATA\lvim\config.lua" }
  ElseIf ($WeztermConfLoc.IsPresent) { Return "$Env:USERPROFILE\.config\wezterm\wezterm.lua" }
  ElseIf ($PSProfileLoc.IsPresent) { Return "$PROFILE" }
  Else { Push-Location "$Env:USERPROFILE\.dotfiles"; v; Pop-Location }
}

# Conditional functions and aliases
# ---------------------------------

## Batcat 'bat' on Windows, 'batcat' on *nix Systems
If (Get-Command bat)
{
  function b { bat --style="numbers,changes,header-filename,header-filesize" $Args }
  function bd { bat --diff $Args }
}

# FZF + Delta
If (Get-Command delta)
{
  # Diff files and folders
  function dif
  {
    Param(
      [Parameter(Position=0)][String]$CmpThis,
      [Parameter(Position=1)][String]$CmpWith,
      [Alias('s')][String]$Scope=".",
      [Alias('f')][Switch]$CmpFiles,
      [Alias('g')][Switch]$CmpGitCommits
    )
    If ($CmpFiles.IsPresent)
    {
      $CmpThis = (fd . $Scope --type f --ignore --ignore-case | fzf --height=20 --prompt="䷁ Compare File1  ")
      If ($CmpThis)
      {
        $CmpWith = (fd . $Scope --type f --ignore --ignore-case | fzf --height=20 --prompt="䷁ Compare File2  ")
        If ($CmpWith) { delta -s $CmpThis $CmpWith }
      }
    }
    ElseIf ($CmpGitCommits.IsPresent)
    {
      If (-Not (Test-Path -PathType Container -Path .git)) { Return }
      $CmpThis = ((git --no-pager log --abbrev-commit --decorate --format=format:'%h %ah %d %s' --all `
                    | fzf --height=20 --prompt="䷁ Compare Commit1  ") -split ' ')[0]
      If ($CmpThis)
      {
        $CmpWith = ((git --no-pager log --abbrev-commit --decorate --format=format:'%h %ah %d %s' --all `
                      | fzf --height=20 --prompt="䷁ Compare Commit2  ") -split ' ')[0]
        If ($CmpWith) { git diff "$CmpThis..$CmpWith" | delta -s }
      }
    }
    ElseIf ((-Not [String]::IsNullOrEmpty($CmpThis)) -And (Test-Path -PathType Leaf -Path $CmpThis))
    {
      If ((-Not [String]::IsNullOrEmpty($CmpWith)) -And (Test-Path -PathType Leaf -Path $CmpWith)) { delta -s $CmpThis $CmpWith }
    }
  }

  # Show modified / untracked files with their diff
  function fgs([Switch]$Existing, [Switch]$New)
  {
    If ($Existing.IsPresent)
    {
      git status -uno --porcelain | `
      fzf --prompt="שׂ Git Added Files  " --preview-window "down:70%" `
          --preview="git diff {2} | delta -s --width=$((Get-Host).UI.RawUI.MaxWindowSize.Width)"
    }
    ElseIf ($New.IsPresent)
    {
      $Local:DiffTmp = "$Env:TEMP\difftmp"
      If (-Not (Test-Path $DiffTmp)) { $Local:TmpFile = nf $DiffTmp }
      git status --porcelain | grep "^??" | `
      fzf --prompt="שׂ Git Untracted Files  " --preview-window right:70% `
          --preview="bat --color=always --style=numbers {2}"
    }
    Else { Write-Output "Option missing" }
  }

  # Show git commits with diff
  function fgc
  {
    git log --pretty=format:"%h %ar %s %an" | `
    fzf --prompt="Commits with Diff  " --preview-window "down:70%" `
        --preview="git show {1} --oneline | delta -s --width=$((Get-Host).UI.RawUI.MaxWindowSize.Width)"
  }
}

If (Get-Command difft)
{
  function dft { difft --display 'side-by-side-show-both' $Args | bat -p }
}

If (Get-Command eza)
{
  function els { eza -F --icons --sort extension --group-directories-first $Args }
  function ell { eza -F --icons --group-directories-first --long $Args }
  function elt { eza --icons --group-directories-first --tree $Args }
}

## Git related stuff
If (Get-Command git)
{
  function g { git $Args }
  function gs { git status }
  function ga { git add $Args }
  function gb { git branch $Args }
  function gck([Switch]$NewBranch)
  {
    If ($NewBranch.IsPresent) { git checkout -b $Args }
    Else { git checkout $Args }
  }
  function gup
  {
    Param(
      [Parameter(Position=0)][String]$file,
      [Parameter(Mandatory=$True, Position=1)][String]$msg,
      [Parameter(Position=2)][String]$branch=(git rev-parse --abbrev-ref HEAD)
    )
    Write-Output "Adding to source control ...`n"
    If ([String]::IsNullOrEmpty($file)) { git add . }
    Else { git add $file }
    Write-Output "Commiting with msg: $msg ...`n"
    git commit -m $msg
    Write-Output "Pushing to remote branch: $branch ..."
    git push origin $branch
  }
}

## GoPass
If (Get-Command gopass)
{
  Set-Alias -Name 'pw' -Value gopass
  function cred
  {
    Param(
      [String]$Add,
      [Switch]$Remove,
      [Switch]$Uname,
      [Switch]$Psswd,
      [Alias('lf')][String]$ListFlat="",
      [Alias('lt')][String]$ListTree=""
    )
    If ($Uname.IsPresent)
    {
      $SecretName = gopass list --flat | fzf -i --prompt="Account Username  " --height=20 --cycle
      If ($SecretName) { Write-Output $SecretName.Split('/')[-1] | clip; Write-Output "Username copied to clipboard" }
    }
    ElseIf ($Psswd.IsPresent)
    {
      $SecretName = gopass list --flat | fzf -i --prompt="Account Password  " --height=20 --cycle
      If ($SecretName) { gopass -c $SecretName }
    }
    ElseIf ($Remove.IsPresent)
    {
      $SecretName = gopass list --flat | fzf -i --prompt="Account Remove  " --height=20 --cycle
      If ($SecretName) { gopass remove $SecretName }
    }
    ElseIf (-Not [String]::IsNullOrEmpty($ListFlat))
    {
      If ($ListFlat -eq "a") { gopass list --flat }
      Else { gopass list --flat }
    }
    ElseIf (-Not [String]::IsNullOrEmpty($ListTree))
    {
      If ($ListTree -eq "a") { gopass list }
      Else { gopass list $ListTree }
    }
    ElseIf (-Not [String]::IsNullOrEmpty($Add)) { gopass insert $Add }
    Else { Write-Output "Option missing. Check 'help cred' for more details" }
  }
}

## IPython
If (Get-Command ipython) { Set-Alias -Name 'ipy' -Value ipython }

## Lazygit
If (Get-Command lazygit) { Set-Alias -Name 'lg' -Value lazygit }

## Mpv
If (Get-Command mpv)
{
  function mpvf([String]$MovFile, [String]$SrtFile) { mpv "$MovFile" --sub-file="$SrtFile" }
}

## Pandoc
If (Get-Command pandoc)
{
  function convmd()
  {
    Param(
      [String]$PathToMDFile="$HOME\Documents\obsidiannotes\Work",
      [String]$FName,
      [Switch]$Docx,
      [Switch]$Pdf
    )
    $ConvDocsPath = "$HOME\Documents\EnsonoWork\ConvertedDocs"
    If (-Not (Test-Path -Path $ConvDocsPath)) { mkdir $ConvDocsPath }
    If ($Docx.IsPresent -or $Pdf.IsPresent)
    {
      $FZF_OUTPUT = (fd . $PathToMDFile --type f --extension 'md' --ignore-case `
                     | fzf --preview="bat --color=always --style=numbers {}" --cycle `
                           --prompt="Convert File  " --height=25)
      If ($FZF_OUTPUT)
      {
        $Ext = ''
        $MermaidFilter = "$HOME\scoop\persist\nodejs\bin\mermaid-filter.cmd"
        If ($Docx.IsPresent) { $Ext = '.docx' }
        Else { $Ext = '.pdf' }
        If ([String]::IsNullOrEmpty($FName)) { $FName = (Get-ChildItem $FZF_OUTPUT | Select-Object BaseName).BaseName }
        $ConvFName = $FName + $Ext
        If ($Docx.IsPresent) { pandoc -o $ConvDocsPath\$ConvFName -f markdown -F $MermaidFilter -t docx $FZF_OUTPUT }
        Else { pandoc -o $ConvDocsPath\$ConvFName -f markdown -F $MermaidFilter --pdf-engine="xelatex" $FZF_OUTPUT }
        Write-Output "Output: $ConvDocsPath\$ConvFName"
      }
    }
    Else { Write-Output "Convert option missing. Specify, in which format to convert to. See 'help convmd'" }
  }
}

## Postgres
If (Get-Command psql)
{
  function pq
  {
    Param (
      [Switch]$RunQry,
      [Switch]$Edit,
      [Switch]$LaunchLocal,
      [Switch]$InsertQry,
      [Switch]$CreateQry,
      [String]$Query
    )
    $DbUrl = "postgresql://admin:Admin%402021@localhost:5432/awx_launcher"
    $DataFile = "$HOME\Documents\EnsonoWork\CsvData\postgres_queries.csv"
    If (-Not [String]::IsNullOrEmpty($Query))
    {
      "$Query" | psql --csv $DbUrl | ConvertFrom-Csv | Format-Table -Wrap
      Return
    }
    ElseIf ($Edit.IsPresent) { v $DataFile; Return; }
    ElseIf ($Launch.IsPresent) { psql $DbUrl }
    ElseIf ($InsertQry.IsPresent)
    {
      $FZF_INSERT_QUERIES = Get-Content $DataFile | Where-Object { $_ -like 'INSERT*' }
      $FZF_INSERT_QUERY = $FZF_INSERT_QUERIES | fzf --height=20 --cycle
      If ($FZF_INSERT_QUERY) { $FZF_INSERT_QUERY | clip; Write-Output "Query copied to clipboard" }
    }
    ElseIf ($CreateQry.IsPresent)
    {
      $FZF_CREATE_QUERIES = Get-Content $DataFile | Where-Object { $_ -like 'CREATE*' }
      $FZF_CREATE_QUERY = $FZF_CREATE_QUERIES | fzf --height=20 --cycle
      If ($FZF_CREATE_QUERY) { $FZF_CREATE_QUERY | clip; Write-Output "Query copied to clipboard" }
    }
    Else
    {
      $FZF_SELECT_QUERIES = Get-Content $DataFile | Where-Object { $_ -like 'SELECT*' }
      $FZF_SELECT_QUERY = $FZF_SELECT_QUERIES | fzf --height=20 --cycle --prompt="Select Query  "
      If ($FZF_SELECT_QUERY) {
        If ($RunQry.IsPresent) {
          $FZF_SELECT_QUERY | Where-Object { $_ -notlike "WHERE" } | psql --csv $DbUrl | ConvertFrom-Csv | Format-Table -Wrap
          Return
        }
        Else { $FZF_SELECT_QUERY | clip; Write-Output "Query copied to clipboard" }
      }
    }
  }
}

# Scoop
If (Get-Command scoop)
{
  function scs { scoop search $Args }
  function sci { scoop install $Args }
  function scu { scoop uninstall $Args }
  function scl([Switch]$su,[Switch]$ss)
  {
    $SortBy = 'Name'
    If ($su.IsPresent) { $SortBy = 'Updated' }
    ElseIf ($ss.IsPresent) { $SortBy = 'Source' }
    scoop list $Args | Select-Object Name,Version,Updated,Source | Sort $SortBy
  }
}
Else { Write-Output "Scoop is not installed. Some function may not work." }

## Wezterm terminal emulator/multiplexer
If (Get-Command wezterm)
{
  Set-Alias -Name wz -Value wezterm
  function wrn([String]$NewName='') { wezterm cli rename-workspace $NewName }
  function wst([String]$NewName='') { wezterm cli set-tab-title $NewName }
  function wlw
  {
    $WsPSObj = Get-Content -Raw "$HOME\.config\wezterm\wezwsconf.json" | ConvertFrom-Json
    $WsName = $WsPSObj.workspaces.PSObject.Properties.Name | fzf --height=20 --cycle --prompt="ﰪ Launch Workspace  "
    If (-Not [String]::IsNullOrEmpty($WSName))
    { 
      # First check if workspace already exists
      $WsTable = $WsPSObj.workspaces.$WSName
      $WezData = wezterm cli list --format json | ConvertFrom-Json
      $WezWs = $WezData.workspace | Select-Object -Unique
      If ($WsName -in $WezWs) { Write-Output "Workspace already exists. Switch using <alt-w>"; Return }

      # If not exists spawn new workspace with tabs defined in json file
      $PaneID = wezterm cli spawn --cwd $WsTable.workdir --workspace $WsName --new-window
      wezterm cli set-tab-title --pane-id $PaneID "Notes"
      $WsTable.tabs | ForEach-Object {
        $Local:PnID = wezterm cli spawn --pane-id $PaneID --cwd $WsTable.workdir
        wezterm cli set-tab-title --pane-id $PnID $_
      }
    }
  }
}

## Winget functions
If (Get-Command winget)
{
  function wl  { winget list $Args }
  function ws  { winget search $Args }
  function wi($Package)  { winget install --source winget --exact --id $Package }
  function wun { winget uninstall --purge $Args }
}

## WSL shutdown
If (Get-Command wsl)
{
  function wsld { wsl --shutdown }
  function wsle { wsl -e bash $Args }
  function wslh { wsl --cd '~' }

  # Taskwarrior 
  function task { wsl task $Args }
  function tw
  {
    Param(
      [Switch]$Projects,
      [Switch]$Summary,
      [Switch]$BrndwnDly,
      [Switch]$Next,
      [Switch]$Tui,
      [Alias('cw')][Switch]$ContxtWrk,
      [Alias('cp')][Switch]$ContxtPrsnl
    )

    If ($Projects.IsPresent) { wsl task rc.list.all.projects=1 projects }
    ElseIf ($Summary.IsPresent) { wsl task summary }
    ElseIf ($BrndwnDly.IsPresent) { wsl task burndown.daily }
    ElseIf ($Next.IsPresent) { wsl task +next limit:5 }
    ElseIf ($Tui.IsPresent) { wsl taskwarrior-tui $Args }
    ElseIf ($ContxtWrk.IsPresent) { wsl task context work }
    ElseIf ($ContxtPrsnl.IsPresent) { wsl task context prsnl }
    Else { wsl task $Args }
  }
  function tm([Switch]$Summary)
  {
    If ($Summary.IsPresent) { wsl timew summary :ids :annotation $Args }
    Else { wsl timew $Args }
  }
}

## Windows Terminal (although highly recommended still we check)
If (Get-Command wt)
{
  function wtc([Switch]$ViewOnly)
  {
    $WTConfFilePath = "$Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    If ($ViewOnly.IsPresent) { b $WTConfFilePath }
    Else { v $WTConfFilePath }
  }
}

## Zoxide Config :: Jump directories faster
If (Get-Command zoxide)
{
  Invoke-Expression (& {
      $hook = If ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } Else { 'pwd' }
      (zoxide init --hook $hook powershell | Out-String)
    })
  Set-Alias -Name 'c' -Value z
}

# Terminal Icons for Powershell
If (-Not (Get-Module -ListAvailable -Name Terminal-Icons))
{
  Write-Output "Module 'Terminal-Icons' not found. Attempting Install from PSGallery.."
  Install-Module -Name Terminal-Icons -Repository PSGallery
}
Else { Import-Module -Name Terminal-Icons }

## Btop4win alias
If (Test-Path "$Env:LOCALAPPDATA\Programs\btop4win")
{
  Set-Alias -Name btop -Value "$Env:LOCALAPPDATA\Programs\btop4win\btop4win.exe"
}

## Notepad++ alias
If (Test-Path "${Env:ProgramFiles(x86)}\Notepad++")
{
  Set-Alias -Name np -Value "${Env:ProgramFiles(x86)}\Notepad++\notepad++.exe"
}
ElseIf (Test-Path "$Env:ProgramFiles\Notepad++")
{
  Set-Alias -Name np -Value "$Env:ProgramFiles\Notepad++\notepad++.exe"
}

## Syncthing
If (Test-Path "$Env:USERPROFILE\scoop\apps\syncthing")
{
  Set-Alias -Name synct -Value "$Env:USERPROFILE\scoop\apps\syncthing\current\syncthing-tray.exe"
}

## Zettelkasten zk command
If (Test-Path -PathType Leaf -Path "$Env:USERPROFILE\MyRepos\zk\zk.exe")
{
  Set-Alias -Name zk -Value "$Env:USERPROFILE\MyRepos\zk\zk.exe"
}

# Aliases of existing powershell commands
Set-Alias -Name 'csv' -Value Import-Csv
Set-Alias -Name 'ip' -Value ipconfig
Set-Alias -Name 'poff' -Value Stop-Computer
Set-Alias -Name 'reboot' -Value Restart-Computer
Set-Alias -Name 'rh' -Value Read-Host

$ErrorActionPreference = 'Continue'
