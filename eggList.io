EggList := Object clone do(
	eggs ::= list()
	
	initialize := method(		
		# Make the directory for the files to go in
		System runCommand("mkdir -p nest")
		
		# Add all of the eggs in eggs.txt to the eggs list
		eggFile := File clone openForReading("./eggs.txt")
		eggFile readLines foreach(i, line,
			eggInfo := line split
				
			newEgg := Egg clone
			newEgg name = eggInfo at(0)
			newEgg location = eggInfo at(1)
			(eggInfo size == 3) ifTrue(
				newEgg version = eggInfo at(2)
			)
			
			newEggIsValid := newEgg assertValid

			(newEggIsValid) ifTrue(
				eggs appendIfAbsent(newEgg)
			)
		)
	)
	
	clean := method(
		System runCommand("rm -r nest/")
	)
	
	install := method(
		# Create the nest directory and the eggs.txt file
		initialize()
		
		# Remove all the files inside the `aves/` directory
		clean()
		
		# Install all of the listed eggs
		"Laying eggs..." println
		eggs foreach(i, egg, egg getPackage)
	)
	
	listAll := method(
		eggs foreach(i, egg,
			eggMessage := ("-> " .. egg name .. " (" .. egg location .. ")")
			(egg version == nil) ifTrue (
				eggMessage println
			) ifFalse (
				(eggMessage .. " [" .. egg version .. "]") println
			)
		)
	)
)