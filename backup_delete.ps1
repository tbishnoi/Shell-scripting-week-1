$title    = 'Delete SQL backup files > 7 days'
$question = 'Are you sure you want to proceed?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Write-Host 'Confirmed'
    $Path = 'D:\Backup\';
    $DaysToKeep = '-7';
    $CurrentDate = Get-Date
    $DatetoDelete = $CurrentDate.AddDays($DaysToKeep)
    Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Recurse
} else {
    Write-Host 'Cancelled'
}

