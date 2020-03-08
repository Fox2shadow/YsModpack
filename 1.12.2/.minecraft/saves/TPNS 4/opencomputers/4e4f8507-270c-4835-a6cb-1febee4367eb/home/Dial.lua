address = {"Aries", "Auriga", "Crater", "Andromeda", "Aquarius", "Leo Minor", "Point of Origin"}

c = require("component")
event = require("event")
os = require("os")
sg = c.stargate

print("Dialing")
for i,v in ipairs(address) do print(i,v) end
print()

function dialNext(dialed)
	glyph = address[dialed + 1]
	print("Engaging "..glyph.."... ")

	sg.engageSymbol(glyph)
end

eventID = event.listen("stargate_spin_chevron_engaged", function(evname, address, caller, num, lock, glyph)	
	os.sleep(2)
		
	if lock then
		if (event.cancel(eventID)) then
			print("Event cancelled successfully")
		end
		
		os.sleep(2)
		
		print("Engaging...")
		sg.engageGate()
		
		doing = false
	else
		dialNext(num)
	end
end)

dialNext(0)
doing = true

while doing do os.sleep(0.5) end