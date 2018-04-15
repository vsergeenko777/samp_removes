rollout part1 "Removes"
(
	group "Import remove data"
	(		
		button imp_wat "Import RemovePlayerBuilding.pwn" width:180 align:#center toolTip:"Import remove data" offset:[0,-5]
	)
	on imp_wat pressed do
	(
		TXT = getOpenFileName types:"SA-MP RemovePlayerBuilding (*.pwn)|*.pwn" 
		if TXT != undefined then
		(		
			txt = openFile TXT
			n = 0
			max select none
			while not eof txt do
			(
				line = readline txt
			
				if line != "" then
				(
					data = filterString line " "

					m_name = ((data[1]) as string)
					x_pos = ((data[2]) as float)
					y_pos = ((data[3]) as float)
					z_pos = ((data[4]) as float)
					rem_dist = ((data[5]) as float)
					
					--format "% % % %\n" m_name x_pos y_pos z_pos
					
					for o in objects do
					(
						if o.name == m_name then
						(
							dist_x_diff = (o.pos[1] - x_pos)
							dist_y_diff = (o.pos[2] - y_pos)
							dist_z_diff = (o.pos[3] - z_pos)
							dist_x_diff2 = (dist_x_diff * dist_x_diff)
							dist_y_diff2 = (dist_y_diff * dist_y_diff)
							dist_z_diff2 = (dist_z_diff * dist_z_diff)
							dist = (sqrt (dist_x_diff2 + dist_y_diff2 + dist_z_diff2))

							if dist < rem_dist then
							(
								o.isHidden = true
							
								format "model % (% % % %) removed\n" m_name x_pos y_pos z_pos rem_dist
							)
						)
					)
				)			
			)
			close txt
		)
	)
)-- end of rollout

rollout aboutrollout "About"
(
	label LabelA "RemoveBuildingForPlayer script"
	label LabelB "by vsergeenko"
)-- end of rollout

if wat != undefined then closeRolloutFloater wat
wat = newRolloutFloater "RemovePlayerBuilding 0.1" 220 160 10 100		
addRollout part1 wat rolledup:false
addRollout aboutrollout wat rolledup:false
