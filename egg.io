Egg := Object clone do(
	name ::= nil
	location ::= nil
	version ::= nil
	
	assertValid := method(
		(location containsSeq("https://")) ifFalse(
			("!! Egg url `" .. location .. "` for egg `" .. name .. "` is invalid.\n") println
			return false
		)
		return true
	)
	
	getPackage := method(
		curlCommand := "curl " .. location .. " --output nest/" .. name .. ".wren"
		(System runCommand(curlCommand) succeeded) ifTrue(
			# Maybe I should stop using the laying egg euphemism now?
			# I think I took it too far LOL
			("    Default egg `" .. name .. "` (" .. location .. ") was successfully layed.") println
		)
	)
)