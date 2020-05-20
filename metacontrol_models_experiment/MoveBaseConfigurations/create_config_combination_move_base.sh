#!/bin/sh
qa_safety=0.0
qa_energy=0.0
echo "configs: [" > rosgraph_manipulator_config.yaml

#for controller_frequency
for i in 1 2 3
do
	if [ $i = 1 ]; then freq=15;fi
	if [ $i = 2 ]; then freq=20;fi
	if [ $i = 3 ]; then freq=25;fi
	#for max_vel_x
	for j in 1 2 3
	do
		if [ $j = 1 ]; then vel=0.3;fi
		if [ $j = 2 ]; then vel=0.5;fi
		if [ $j = 3 ]; then vel=0.75;fi
		#for inflation_radius
		for k in 1 2 3
		do
			if [ $k = 1 ]; then rad=0.3;fi
			if [ $k = 2 ]; then rad=0.45;fi
			if [ $k = 3 ]; then rad=0.6;fi
			system_name="f${i}_v${j}_r${k}"
			file_name="${system_name}.rossystem"
			touch ${file_name}
			echo "RosSystem { Name '${system_name}'  RosComponents (\n    ComponentInterface { name move_base NameSpace 'move_base'\n        RosParameters{" > ${file_name}
			echo "            RosParameter 'controller_frequency' { RefParameter 'move_base.move_base.move_base.controller_frequency' value $freq}," >> ${file_name}
			echo "            RosParameter 'max_vel_x' { RefParameter 'move_base.move_base.move_base.max_vel_x' value $vel}," >> ${file_name}
			echo "            RosParameter 'inflation_radius' { RefParameter 'move_base.move_base.move_base.inflation_radius' value $rad}" >> ${file_name}
			echo "    }})" >> ${file_name}
			echo "    Parameters {" >> ${file_name}
			echo "        Parameter { name qa_safety type Double value $qa_safety}," >> ${file_name}
			echo "        Parameter { name qa_energy type Double value $qa_energy}}" >> ${file_name}
			echo "    }" >> ${file_name}
			echo "'${system_name}'," >>  rosgraph_manipulator_config.yaml
		done
	done
done
sed -i '$ s/.$//' rosgraph_manipulator_config.yaml
echo "]" >> rosgraph_manipulator_config.yaml
echo $(tr -d '\n' < rosgraph_manipulator_config.yaml) > rosgraph_manipulator_config.yaml

