------------------------------------------------------------------------------------------------------
-- convert_PointCache_2_VertexAnim.ms  script
-- Author: Sergey <Neill> Solohin, all rights reserved.
-- e-mail to: s@neill3d.com
-- downloaded from www.neill3d.com
------------------------------------------------------------------------------------------------------

macroScript ConvertVtx
	buttonText:"Convert to vertex animation" 
	category:"Neill3d"
	internalcategory:"Animation"
(

rollout convertVtxAnimRollout "Convert point cache" width:160 height:271
(
	button btnConvert "Convert" pos:[16,83] width:128 height:32
	button btnHold "Hold" pos:[16,162] width:128 height:32
	button btnFetch "Fetch" pos:[16,200] width:128 height:32
	label lblStatus "Neill3d.com 2012" pos:[16,245] width:128 height:16
	GroupBox grp1 "transfering" pos:[9,146] width:144 height:92
	pickbutton btnSrc "Src node" pos:[17,9] width:53 height:30
	pickbutton btnDst "DstNode" pos:[86,8] width:57 height:32
	
	spinner spn1 "start" pos:[11,54] range:[-3000, 30000, 0] width:53 height:16
	spinner spn2 "end" pos:[76,55] range:[-3000, 30000, 0] width:81 height:16

	button btnMerge "Merge 2 cache files" pos:[16,118] width:128 height:28
	
	
	fn SavePTS obj startFrame endFrame =
	(
		f=fopen "c:\\vertexAnim.pts" "wb"
	 	if (f != undefined) then
	  	(
			-- version (number of points)
			WriteLong f (obj.verts.count)
			
			-- cache samples
			WriteLong f 1
			
			-- cache number of frames
			WriteLong f (endFrame - startFrame)
			
			lblStatus.text = "please wait..."
			
			count = obj.verts.count
			for i = startFrame to endFrame do
			at time i
			(
				for j = 1 to count do
				(
					WriteFloat f obj.verts[j].pos.x
					WriteFloat f obj.verts[j].pos.y
					WriteFloat f obj.verts[j].pos.z
				)
				
				print i
			)
			
	  		fclose f
			
			lblStatus.text = "writing ready"
		)
	)
	
	fn Save2PTS obj obj2 startFrame endFrame endFrame2 =
	(
		-- first of all write to point cache first object movement
		-- then store point animation from another object (push back)
		
		f=fopen "c:\\vertexMergeAnim.pts" "wb"
	 	if (f != undefined) then
	  	(
			-- version (number of points)
			WriteLong f (obj.verts.count)
			
			-- cache samples
			WriteLong f 1
			
			-- cache number of frames
			WriteLong f (endFrame2 - startFrame)
			
			lblStatus.text = "please wait..."
			
			count = obj.verts.count
			-- store from first object
			for i = startFrame to endFrame do
			at time i
			(
				for j = 1 to count do
				(
					WriteFloat f obj.verts[j].pos.x
					WriteFloat f obj.verts[j].pos.y
					WriteFloat f obj.verts[j].pos.z
				)
				
				print i
			)
			-- store from second object
			s = endFrame+1
			for i = s to endFrame2 do
			at time i
			(
				for j = 1 to count do
				(
					WriteFloat f obj2.verts[j].pos.x
					WriteFloat f obj2.verts[j].pos.y
					WriteFloat f obj2.verts[j].pos.z
				)
				
				print i
			)
			
	  		fclose f
			
			lblStatus.text = "writing ready"
		)
	)
	
	
	fn SaveVertexAnimToFile obj startFrame endFrame =
	(
		f = openFile "C:\vertexBake.tmp" mode: "w+"
	 	if (f != undefined) then
	  	(
			print startFrame to: f
			print endFrame to: f
			
			print obj.verts.count to: f
			
			lblStatus.text = "please wait..."
			
			count = obj.verts.count
			for i = startFrame to endFrame do
			at time i
			(
				for j = 1 to count do
				(
					format "% % %\n" obj.verts[j].pos.x obj.verts[j].pos.y obj.verts[j].pos.z to: f
				)
				
				print i
			)
			
	  		close f
			
			lblStatus.text = "writing ready"
		)
	)
	
	fn strToArray str delims  = 
	(
		local delimStr = "" 
		for d in delims do delimStr += d
		filterString str delimStr
	)
	
	fn LoadVertexAnimFromFile obj startFrame endFrame =
	undo "loadVertexAnim" on
	(
			
		f = openFile "C:\vertexBake.tmp" mode: "r"
		if (f != undefined) then
		(
			s = readLine f   -- line with startT & endT params
			sT = s as integer
			s = readLine f
			sE = s as integer
			sLen = sE - sT
			
			-- vertices count 
			s = readLine f
			sCount = s as integer
			print sCount
			print obj.verts.count
			
			if (sCount != obj.verts.count) then
			(
				close f
				print ("wrong vertices count")
				return 0
			)
			
			-- prepare object
			convertToMesh obj
			update obj
			animateVertex obj #all

			properties = getPropNames obj #dynamicOnly
			conts  = #()

			for p in properties do
				append conts (getPropertyController obj p)
			
			p = point3 0.0 0.0 0.0
			
			-- reading information
			for i = sT to sE do
			(
				-- skip unneeded frames
				if (i < startFrame) then 
				(
					for j = 1 to sCount do
						s = readLine f
					continue
				)
				if (i > endFrame) then exit
				
				for j = 1 to sCount do
				(
					s = readLine f
					tr = (strToArray s #(" ", "\t"))
					
					p.x = tr[1] as float
					p.y = tr[2] as float
					p.z = tr[3] as float
					
					k = addNewKey conts[j] i -- add another key
					k.value = p -- set value
				)
				
				print i
			)
	
			close f
			
			lblStatus.text = "reading ready!"
		)
	)
	
	fn ConvertPointCache src dst startFrame endFrame =
	undo "convertCache" on
	(
		convertToMesh dst
		update dst
		animateVertex dst #all

		properties = getPropNames dst #dynamicOnly
		conts  = #()

		for p in properties do
			append conts (getPropertyController dst p)

		n =properties.count
		for i = startFrame to endFrame do
		at time i
		(
			for ndx = 1 to n do
			(
				k = addNewKey conts[ndx] i -- add another key at 100
				k.value =  in coordsys local src.verts[ndx].pos -- set value
			)
			
			print i
		)

		lblStatus.text = "convert ready"
	)
	
	-- do convert operation	
	on btnConvert pressed do
	(
		if (btnSrc.object == undefined) then
			if (selection.count > 0) then 
			(
				btnSrc.object = selection[1]
			)
				
		if (btnDst.object == undefined) then
			if (selection.count > 1) then
			(
				btnDst.object = selection[2]
			)
			
		if (btnSrc.object == undefined) or (btnDst.object == undefined) then
			(
				print( "You need to choose src and dst node's" )
			)
			else ConvertPointCache btnSrc.object btnDst.object spn1.value spn2.value
	)
	on btnHold pressed do
	(
		-- do hold operation
		/*
		if (selection.count == 1) then SaveVertexAnimToFile $ spn1.value spn2.value
		else print ("You need to select only one object")
		*/
		if (selection.count == 1) then SavePTS $ spn1.value spn2.value
		else print ("You need to select only one object")
	)
	
	on btnMerge pressed do
	(
		endFrame = animationRange.end.frame as float
		if (selection.count == 2) then Save2PTS selection[1] selection[2] spn1.value spn2.value endFrame
		else print ("You need to select two objects")
	)
	
	on btnFetch pressed do
	(
		-- do fetch operation
		if (selection.count == 1) then LoadVertexAnimFromFile $ spn1.value spn2.value
		else print ("You need to select only one object")
	)
	on btnSrc picked obj do
	(
		-- src node
		btnSrc.text = obj.name
	)
	on btnDst picked obj do
	(
		-- dst node
		btnDst.text = obj.name
	)
	
	on convertVtxAnimRollout open do
	(
		spn1.value = animationRange.start.frame as float 
		spn2.value = animationRange.end.frame as float
		
		print spn1.value
	)
)

createDialog convertVtxAnimRollout

)