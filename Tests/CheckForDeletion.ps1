param(
    [string]$Resourcegroup
)
$Parameters = @{
    ResourcegroupName     = $ResourceGroup
    Templatefile          = "./StorageAccount/azuredeploy.json"
    TemplateParameterFile = "./StorageAccount/azuredeploy.parameters.json"
    Mode                  = 'Complete'
}
$Result = Get-AzResourceGroupDeploymentWhatIfResult @Parameters
$Deleted = $result.Changes | Where-Object { $_.ChangeType -eq 'Delete' }
if ($Deleted.Count -gt 0) {
    Throw "$($Deleted.Count) resources would be removed"
}