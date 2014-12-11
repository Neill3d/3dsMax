
--
-- Animation Time Range Switcher by Neill (neill3d.com)
--

macroscript TimeRangeSwitcher category: "Anim - neill3d"
(
	global tempFirstUse=true
	global tempTimeStart=0
	global tempTimeEnd=100
	
	on Execute do (
		if tempFirstUse then
		(
			tempTimeStart = animationRange.start
			tempTimeEnd = animationRange.end
		
			tempFirstUse = false
		) else (
			tempStart = animationRange.start
			tempEnd = animationRange.end

			animationRange = interval tempTimeStart tempTimeEnd
			
			tempTimeStart = tempStart
			tempTimeEnd = tempEnd		
		)
	)
)