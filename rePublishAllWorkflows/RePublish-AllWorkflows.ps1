#	1. execute with admin privelages; 
#	2. needs library: Sharepoint.Workflows.dll

cls

Add-PSSnapin Microsoft.Sharepoint.Powershell -ErrorAction SilentlyContinue
Add-Type -Path "D:\!Tools\Scripts\rePublishAllWorkflows\Sharepoint.Workflows.dll"
$sctiptModes = New-Object psobject -Property @{RepublishAll = 0; RepublishWebWfOnly = 1; RepublishListsWfOnly = 2}

$web = Get-SPWeb -Identity "http://srv-test-224.ponyex.local"
$sctiptMode = $sctiptModes.RepublishAll

if($web -isnot [Microsoft.SharePoint.SPWeb]){
	throw "Web not found"
}

function PublishWebWfOnly(){
	Write-Host "Getting workflow associations..." -ForegroundColor Blue
	$webWorkflowAssociations = [Sharepoint.Workflows.WorkflowCurrent]::GetWebWorkflowAssociations($web)
	Write-Host "Workflow associations count:" $webWorkflowAssociations.Count

	Write-Host "Getting workflow proxies..." -ForegroundColor Blue
	$webWorkflowProxies = [Sharepoint.Workflows.WorkflowProxy]::Get($web, $webWorkflowAssociations)
	Write-Host "Workflow proxies count:" $webWorkflowProxies.Count

	Write-Host "Creating nintex workflow service proxy..." -ForegroundColor Blue
	$nwService = New-Object Sharepoint.Workflows.NintexWorkflowWSProxy($web)

	Write-Host "Publishing..." -ForegroundColor Blue
	foreach($wfProxy in $webWorkflowProxies){
		Write-Host $wfProxy.Title
		
		$result = $nwService.NintexWorkflowWebService.PublishFromNWFSkipValidation($wfProxy.OutputWorkflowStringByteArray, "", $wfProxy.Title, $true)
		if($result){
			Write-Host "Publish success" -ForegroundColor Green
		}else{
			Write-Host "Publish failure" -ForegroundColor Red
		}
	}
}

function PublishListsWfOnly(){
	Write-Host "Getting workflow associations..." -ForegroundColor Blue
	$listsWorkflowAssociations = [Sharepoint.Workflows.WorkflowCurrent]::GetListWorkflowAssociations($web)
	Write-Host "Workflow associations count:" $listsWorkflowAssociations.Count

	Write-Host "Getting workflow proxies..." -ForegroundColor Blue
	$listsWorkflowProxies = [Sharepoint.Workflows.WorkflowProxy]::Get($web, $listsWorkflowAssociations)
	Write-Host "Workflow proxies count:" $listsWorkflowProxies.Count

	Write-Host "Creating nintex workflow service proxy..." -ForegroundColor Blue
	$nwService = New-Object Sharepoint.Workflows.NintexWorkflowWSProxy($web)

	Write-Host "Publishing..." -ForegroundColor Blue
	foreach($wfProxy in $listsWorkflowProxies){
		Write-Host $wfProxy.Title
		
		$listForPublish = [Sharepoint.Workflows.WorkflowCurrent]::GetListByWorkflowName($web, $wfProxy.Title)
		if($listForPublish -eq $null){
			Write-Host ("List for publish workflow '{0}' not found" -f $wfProxy.Title) -ForegroundColor Red
			continue
		}
		
		$result = $nwService.NintexWorkflowWebService.PublishFromNWFSkipValidation($wfProxy.OutputWorkflowStringByteArray, $listForPublish.Title, $wfProxy.Title, $true)
		if($result){
			Write-Host "Publish success" -ForegroundColor Green
		}else{
			Write-Host "Publish failure" -ForegroundColor Red
		}
	}
}

if(@($sctiptModes.RepublishWebWfOnly, $sctiptModes.RepublishAll) -contains $sctiptMode){
	Write-Host "Web workflows..."
	PublishWebWfOnly
}
if(@($sctiptModes.RepublishListsWfOnly, $sctiptModes.RepublishAll) -contains $sctiptMode){
	Write-Host "List workflows..."
	PublishListsWfOnly
}