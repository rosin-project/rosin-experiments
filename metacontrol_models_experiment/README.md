# metacontrol_models_experiment

This repository holds a project model created using the [ROS tooling](https://github.com/ipa320/ros-model/)



### ROSSystem model to design the application

The main purpose of the project is the definition of the complete system of the metacontrol experiment. The entire system is described by a [Rossystem](system.rossystem) file (which for a ROS developer represent all the information contained on a launch file) , but first, as also ROS does, the ROS nodes that compose the system have to be "implemented", for the ROS Tooling that means that the ROS nodes have to  be described using  [ROS models](rosnodes).

This project was created performing the following steps:

- Create a ROS project: https://github.com/ipa320/ros-model/blob/master/docu/NewProject.md 

- Create within the ROS project a .ros file under rosnodes/ for all the nodes to be analyzed of the application 

  => the "Step 1: use the ROS developer perspective to describe ROS nodes" of the following tutorial cover both previous steps: https://seronet-project.github.io/SeRoNet-examples/SeRoNet-Tooling-ROS-Mixed-Port/

- Create a new ROS system file and add all the components using the Sirius representation for system  https://github.com/ipa320/ros-model/blob/master/docu/NewSystem.md (using the button "New component" of the side toolbar)

Short note for ROS tooling beginners:

- ROS model = information of a node "extracted" from its source code (cpp, python...): Name of the ROS package that contains the node, name of the node and list of interfaces (topics, services, actions and parameters). Also (but usually on a separated file) definition of the communication objects (msgs, srvs and actions).
- ROSSystem model = information of a system at design time (extracted from a launch file) or at runtime (extracted introspecting the rosmaster): Name of the system, **reference** to all the running nodes (ROS models) , (optionally) namespace for a ros node, (optionally) remap or namespace of the interfaces of the ROS model and global parameters. (..... or using other words) -> Instantiations of ROS nodes (represented by the ROS models) and global parameters that are application specific.

### Function Designs models for move_base

A bash script help the user to auto generate all the rossystem file associated to each application configuration for the move_base node. 

Execute:

```
$ cd metacontrol_models_experiment/MoveBaseConfigurations/
$./create_config_combination_move_base.sh
```

The previous command will auto-generate 27 Rossystem files that represent the 27 alternative configurations for *move_base*. If you import these Rossystem file to the ROS tooling you will get per configuration file a new ROS package which contains a launch file to start each configuration  under the folder src-gen of this project (the auto-build function of eclipse has to be enabled).



### Observers (tbd)



----

The folder [models_backup](models_backup) includes some experiment done during the consolidation of the experiment that seem to not be relevant for the current approach.

