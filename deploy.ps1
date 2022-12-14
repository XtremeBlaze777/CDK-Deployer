python cdk.json-fix.py windows
if ( $LastExitCode -eq 2 ) {
	exit
}

cdk bootstrap

$STACKNUM = Read-Host "How many stacks will you be deploying? (enter 0 if none)"
$STACKLIST = @()
$COMMAND = "cdk deploy"

for ($i = 1; $i -le $STACKNUM; $i++) {
	$TMP = Read-Host "Name of Stack $i"
	$STACKLIST += @( $TMP )
	$COMMAND += " $TMP"
}

foreach ($STACK in $STACKLIST) {
	Start-Sleep -Seconds 1
	$PARAMS = Read-Host "How many parameters does $STACK take? (Enter 0 if none)"
	
	if ( $PARAMS -gt 0 ) {
		for ($PARAM = 1; $PARAM -le $PARAMS; $PARAM++) {
			$NAME = Read-Host "Enter parameter $PARAM's name (not the value) listed in your CDK code"
			$VALUE = Read-Host "Enter $NAME's value"

			$COMMAND+=" --parameters $STACK`:$NAME=$VALUE"
		}
	}
}

Write-Output "Deploying your CDK project"
Start-Sleep -Seconds 2

Invoke-Expression $COMMAND
