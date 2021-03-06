cls
<##################################################################
Capacity Planner Data Tool
Args usage = script "path to csv" "path to results"
##################################################################>

# Import the CSV file from Capacity Planner
$datapath = $args[0]
$dataresults = $args[1]

# Find any of the IChassis data within the CSV
$dataimport = Import-Csv -Path $datapath -Delimiter "`"" -Header "C01","C02","C03","C04","C05","C06","C07","C08","C09","C10","C11","C12","C13","C14","C15","C16","C17","C18","C19","C20","C21","C22","C23","C24","C25","C26","C27","C28","C29","C30" `
| Where {$_.C01 -match "IChassis"}

# Find the physical systems
$physical = $dataimport | Where {$_.C09 -notmatch "Virtual"}

	$PhysicalReport = @()
	
	foreach ($line in $physical)
			{			
			$Report = {} | select Server,Make,Model
			$Report.server = $line.C05
			$Report.make = $line.C07
			$Report.model = $line.C09
			$PhysicalReport += $Report
			}
	
	$PhysicalReport | Export-Csv -Path ($dataresults + '\CapPlanner-Physical.csv') -NoTypeInformation

# Find the virtual systems
$virtual = $dataimport | Where {$_.C09 -match "Virtual"}

	$VirtualReport = @()
	
	foreach ($line in $virtual)
			{			
			$Report = {} | select Server,Make,Model
			$Report.server = $line.C05
			$Report.make = $line.C07
			$Report.model = $line.C09
			$VirtualReport += $Report
			}
	
	$VirtualReport | Export-Csv -Path ($dataresults + '\CapPlanner-Virtual.csv') -NoTypeInformation