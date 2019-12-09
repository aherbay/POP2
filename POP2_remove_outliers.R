## Remove outlier entirely

for each item {

if (voltage > threshold)  { 
	current_line <- 
	# enlever tous les Trigger_code pour ce participant (toutes les electrodes)
	set <- subset (set, !(Subject== current_line$Subject & Trigger_code == current_line$Trigger_code) )
}

}

return set

