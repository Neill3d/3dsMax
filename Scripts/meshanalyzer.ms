macroscript MeshAnalyzer category: "NEILL3D"
(
	-- make sure a single mesh object is selected
	on IsEnabled return true
	
	on Execute do (
		
		-- edge workflow
		rollout edgeRollout "Edges" width:162 height:65
		(
			--button edgePlus "+" pos:[9,10] width:18 height:18
			button edgeSelect "S" pos:[29,10] width:18 height:18
			label edgeLabel "all edge(s)" pos:[60,12] width:83 height:16
			button edgeOpenPlus "+" pos:[9,34] width:18 height:18
			button edgeOpenSelect "S" pos:[29,34] width:18 height:18
			label edgeOpenLabel "open edge(s)" pos:[60,35] width:83 height:16
		
			-- select all edges
			on edgeSelect pressed  do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object
				
					max modify mode -- Switch to Modify panel
					subObjectLevel = 2 -- Set Sub-Object level to Edge
			
					edgesCount = obj.Edges.count
					setEdgeSelection obj #{1..edgesCount}
				)
			)
			
			-- select open edges
			on edgeOpenSelect pressed  do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object
			
					max modify mode -- Switch to Modify panel
					subObjectLevel = 2 -- Set Sub-Object level to Edge
				
					openedges = polyOp.getOpenEdges obj
					setEdgeSelection obj openedges
				)
			)
			
			on edgeOpenPlus pressed  do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object
			
					max modify mode -- Switch to Modify panel
					subObjectLevel = 2 -- Set Sub-Object level to Edge
				
					openedges = polyOp.getOpenEdges obj
					oldEdgeSel = getEdgeSelection obj
					
					openedges = join oldEdgeSel openedges 
					setEdgeSelection obj openedges
				)
			)
		)
		
		-- poly workflow
		rollout polyRollout "Polys" width:162 height:254
		(
			--button polyPlus "+" pos:[9,10] width:18 height:18
			button polySelect "S" pos:[29,10] width:18 height:18
			label polyLabel "all poly(s)" pos:[60,12] width:83 height:16
			button point1PolyPlus "+" pos:[9,34] width:18 height:18
			button point1PolySelect "S" pos:[29,34] width:18 height:18
			label point1PolyLabel "1 point poly(s)" pos:[60,35] width:83 height:16
			button point2PolyPlus "+" pos:[9,57] width:18 height:18
			button point2PolySelect "S" pos:[29,57] width:18 height:18
			label point2PolyLabel "2 points poly(s)" pos:[60,58] width:83 height:16
			button point3PolyPlus "+" pos:[9,81] width:18 height:18
			button point3PolySelect "S" pos:[29,81] width:18 height:18
			label point3PolyLabel "3 points poly(s)" pos:[60,82] width:83 height:16
			button point4PolyPlus "+" pos:[9,104] width:18 height:18
			button point4PolySelect "S" pos:[29,104] width:18 height:18
			label point4PolyLabel "4 points poly(s)" pos:[60,105] width:83 height:16
			button multiPolyPlus "+" pos:[9,127] width:18 height:18
			button multiPolySelect "S" pos:[29,127] width:18 height:18
			label multiPolyLabel "multi points poly(s)" pos:[60,128] width:97 height:16
			button insidePolyPlus "+" pos:[9,150] width:18 height:18
			button insidePolySel "S" pos:[29,150] width:18 height:18
			label lbl8 "inside poly(s)" pos:[60,151] width:97 height:16
			GroupBox grp2 "Select by square" pos:[5,180] width:146 height:65
			button sPlus "+" pos:[11,222] width:18 height:18
			button sSelect "S" pos:[31,222] width:18 height:18
			label sLabel "poly(s)" pos:[62,224] width:83 height:16
			spinner sValue "max square" pos:[35,200] width:99 height:16 range:[0,10000,50]
		
			
			-- select all polygons
			on polySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
					
					polyCount = obj.Faces.count
					setFaceSelection obj #{1..polyCount}
				)
			)
			
			-- select 1-point faces
			on point1PolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 1) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			on point1PolySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 1) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			
			
			-- select 2-point faces
			on point2PolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 2) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			on point2PolySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 2) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			
			-- select 3-point faces
			on point3PolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 3) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			on point3PolySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 3) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			
			-- select 4-point faces
			on point4PolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 4) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			on point4PolySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face == 4) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)

			)
			
			-- select multi-point faces
			on multiPolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face > 4) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)
			)
			on multiPolySelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						if (obj.GetFaceDegree face > 4) then
							append faceSel face
					)
				
					obj.setSelection #Face faceSel
				)
			)
			
			
			-- select from area
			on sPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object
			
					max modify mode
					subobjectLevel = 4

					--faceSel= #{}
					faceSel = obj.getSelection #Face
				
					for f = 1 to obj.numfaces do
					(	
						if (polyOp.getFaceArea obj f) < sValue.value then
							append faceSel f
					)
				
					obj.setSelection #Face faceSel
				)
			)
			on sSelect pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object
			
					max modify mode
					subobjectLevel = 4

					faceSel= #{}
				
					for f = 1 to obj.numfaces do
					(	
						if (polyOp.getFaceArea obj f) < sValue.value then
							append faceSel f
					)
				
					obj.setSelection #Face faceSel
				)
			)
			
			--
			-- inside poly's selection
			--
			
			fn getVectorsAngle n1 n2 = ( acos (dot (normalize n1) (normalize n2)) )

			fn vertInPolyVert p poly_verts verticeCount =
			(
				result = false
				
				for i = 1 to verticeCount do
				(
					if p == poly_verts[i] then
					( 
						result = true
						return result
					)
				)
				
				return result
			)

			fn InsidePolygon vIntersection poly_verts verticeCount =
			(
				MATCH_FACTOR = 0.99
				
				Angle = 0.0
				vA = [0.0, 0.0, 0.0]
				vB = [0.0, 0.0, 0.0]
				for i = 1 to verticeCount do
				(
					vA = poly_verts[i] - vIntersection
					reminder = (mod i verticeCount) as integer
					reminder = reminder + 1
					vB = poly_verts[reminder] - vIntersection
					Angle += getVectorsAngle vA vB
				)
				Angle = degToRad Angle
				print Angle
				print (MATCH_FACTOR * (2*pi) )
				if (Angle >= (MATCH_FACTOR * (2*pi)) ) then return true
				else return false
			)			
			
			
			on insidePolyPlus pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					--faceSel=#{} -- Init. an Array
					faceSel = obj.getSelection #Face
					
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						face_ndx = polyOp.GetFaceVerts obj face
						face_count = face_ndx.count
						face_verts = #()
						for ii = 1 to face_count do
							face_verts[ii] = polyOp.GetVert obj face_ndx[ii]
						
						if ( face_count < 3) then continue
						face_normal = polyOp.GetFaceNormal obj face
						face_D = -(face_verts[1].x*face_normal.x + face_verts[1].y*face_normal.y + face_verts[1].z*face_normal.z )
						
						for k = 1 to obj.GetNumFaces() do
						(
							if (face == k) then continue
							
							ndx = polyOp.GetFaceVerts obj k
							count = ndx.count
							if ( count < 3) then continue
							
							verts = #()
							for ii = 1 to count do
								verts[ii] = polyOp.GetVert obj ndx[ii]
							
							normal = polyOp.GetFaceNormal obj k
							angle = getVectorsAngle face_normal normal
							if ( (angle != 0) and (angle != 180) ) then continue
					
							D = -(verts[1].x*normal.x + verts[1].y*normal.y + verts[1].z*normal.z )
							format "check D % and % \n" face_D D
							if (D != face_D) then continue 

							format "check inside between % and %\n" face k
							IsInside = true
							for jj = 1 to count do
							(
								if (vertInPolyVert verts[jj] face_verts face_count) == false then
									if (InsidePolygon verts[jj] face_verts face_count) == false then IsInside = false
							)
							
							-- !k poly is inside face poly!
							if IsInside then
								append faceSel k
						)
					)
				
					obj.setSelection #Face faceSel
				)
			)
			
			
			on insidePolySel pressed do
			(
				if selection.count == 1 and classof selection[1] == Editable_Poly then
				(
					obj = selection[1] 		-- get selected object

					max modify mode
					subObjectLevel = 4
				
					faceSel=#{} -- Init. an Array
					for face = 1 to obj.GetNumFaces() do -- Go through all faces
					(
						face_ndx = polyOp.GetFaceVerts obj face
						face_count = face_ndx.count
						face_verts = #()
						for ii = 1 to face_count do
							face_verts[ii] = polyOp.GetVert obj face_ndx[ii]
						
						if ( face_count < 3) then continue
						face_normal = polyOp.GetFaceNormal obj face
						face_D = -(face_verts[1].x*face_normal.x + face_verts[1].y*face_normal.y + face_verts[1].z*face_normal.z )
						
						for k = 1 to obj.GetNumFaces() do
						(
							if (face == k) then continue
							
							ndx = polyOp.GetFaceVerts obj k
							count = ndx.count
							if ( count < 3) then continue
							
							verts = #()
							for ii = 1 to count do
								verts[ii] = polyOp.GetVert obj ndx[ii]
							
							normal = polyOp.GetFaceNormal obj k
							angle = getVectorsAngle face_normal normal
							if ( (angle != 0) and (angle != 180) ) then continue
					
							D = -(verts[1].x*normal.x + verts[1].y*normal.y + verts[1].z*normal.z )
							format "check D % and % \n" face_D D
							if (D != face_D) then continue 

							format "check inside between % and %\n" face k
							IsInside = true
							for jj = 1 to count do
							(
								if (vertInPolyVert verts[jj] face_verts face_count) == false then
									if (InsidePolygon verts[jj] face_verts face_count) == false then IsInside = false
							)
							
							-- !k poly is inside face poly!
							if IsInside then
								append faceSel k
						)
					)
				
					obj.setSelection #Face faceSel
				)
			)
		)	
	
		rollout aboutRollout "About" width:162 height:69
		(
			label aboutLabel "(C) 2009 www.neill3d.com" pos:[8,8] width:142 height:20
			--label authorLabel "Author: Sergey Solohin (Neill)" pos:[7,34] width:144 height:19
			--label emailLabel "e-mail to: neill@bk.ru" pos:[6,49] width:143 height:27
		)		
		
		theAnalyzeFloater = newRolloutFloater "Mesh Analyzer" 170 400
		addRollout edgeRollout theAnalyzeFloater
		addRollout polyRollout theAnalyzeFloater
		addRollout aboutRollout theAnalyzeFloater rolledUp:true
	) -- end on (execution)
)