#!/usr/bin/env bash
#min value for qa_safety
qa_safety=(0.68 0.7 0.71 0.41 0.42 0.42 0.28 0.27 0.26 0.66 0.69 0.71 0.41 0.42 0.43 0.28 0.28 0.28 0.62 0.7 0.69 0.42 0.41 0.42 0.28 0.28 0.29)
#max value for qa_energy
qa_energy=( 0.34 0.33 0.33 0.48 0.49 0.49 0.73 0.76 0.7 0.38 0.36 0.38 0.48 0.57 0.49 0.67 0.78 0.66 0.39 0.4 0.4 0.55 0.59 0.59 0.78 0.74 0.74)
count=0
echo "configs: [" > rosgraph_manipulator_config.yaml
global_path="../src-gen/"
#for controller_frequency
for i in 1 2 3
do
	if [ $i = 1 ]; then freq=15;fi
	if [ $i = 2 ]; then freq=20;fi
	if [ $i = 3 ]; then freq=25;fi
	freq_f5=$(echo "scale=1;$freq/5" |bc)
	freq_f2=$(echo "scale=1;$freq/2" |bc)
	#for max_vel_x
	for j in 1 2 3
	do
		if [ $j = 1 ]; then vel=0.3;fi
		if [ $j = 2 ]; then vel=0.5;fi
		if [ $j = 3 ]; then vel=0.75;fi
		acc=$(echo "scale=2;$vel*12" |bc)
		#for inflation_radius
		for k in 1 2 3
		do
			if [ $k = 1 ]; then rad=0.5;fi
			if [ $k = 2 ]; then rad=0.65;fi
			if [ $k = 3 ]; then rad=0.8;fi
			system_name="f${i}_v${j}_r${k}"
			relative_path=${system_name}/
			mkdir -p "${global_path}${relative_path}"
			file_name="${global_path}${relative_path}${system_name}.rossystem"
			touch ${file_name}
			echo -e "RosSystem { Name '${system_name}'  RosComponents (\n    ComponentInterface { name move_base \n        RosParameters{" > ${file_name}
			echo -e "            RosParameter 'controller_frequency' { RefParameter 'move_base.move_base.move_base.controller_frequency' value $freq}," >> ${file_name}
			echo -e "            RosParameter 'planner_frequency' { RefParameter 'move_base.move_base.move_base.planner_frequency' value $freq_f5}," >> ${file_name}
			echo -e "            RosParameter 'global/update_frequency' { RefParameter 'move_base.move_base.move_base.global_costmap/update_frequency' value $freq_f5}," >> ${file_name}
			echo -e "            RosParameter 'local/update_frequency' { RefParameter 'move_base.move_base.move_base.local_costmap/update_frequency' value $freq_f2}," >> ${file_name}
			echo -e "            RosParameter 'max_vel_x' { RefParameter 'move_base.move_base.move_base.TrajectoryPlannerROS/max_vel_x' value $vel}," >> ${file_name}
			echo -e "            RosParameter 'max_vel_y' { RefParameter 'move_base.move_base.move_base.TrajectoryPlannerROS/max_vel_y' value $vel}," >> ${file_name}
			echo -e "            RosParameter 'acc_lim_x' { RefParameter 'move_base.move_base.move_base.TrajectoryPlannerROS/acc_lim_x' value $acc}," >> ${file_name}
			echo -e "            RosParameter 'acc_lim_y' { RefParameter 'move_base.move_base.move_base.TrajectoryPlannerROS/acc_lim_y' value $acc}," >> ${file_name}
			echo -e "            RosParameter 'inflation_radius' { RefParameter 'move_base.move_base.move_base.local_costmap/inflater_layer/inflation_radius' value $rad}," >> ${file_name}
			echo -e "            RosParameter 'inflation_radius' { RefParameter 'move_base.move_base.move_base.global_costmap/inflater_layer/inflation_radius' value $rad}" >> ${file_name}
			echo -e "    }})" >> ${file_name}
			echo -e "    Parameters {" >> ${file_name}
			echo -e "        Parameter { name qa_safety type Double value ${qa_safety[$count]}}," >> ${file_name}
			echo -e "        Parameter { name qa_energy type Double value ${qa_energy[$count]}}}" >> ${file_name}
			echo -e "    }" >> ${file_name}
			echo "'${system_name}'," >>  rosgraph_manipulator_config.yaml
			count=$((count+1))
		done
	done
done
sed -i '$ s/.$//' rosgraph_manipulator_config.yaml
echo "]" >> rosgraph_manipulator_config.yaml
echo $(tr -d '\n' < rosgraph_manipulator_config.yaml) > rosgraph_manipulator_config.yaml

