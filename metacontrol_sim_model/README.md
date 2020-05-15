# metacontrol_sim_model

The files of this project were created automatically by calling the [ros_graph_parser](https://github.com/ipa-nhg/ros_graph_parser/tree/SoSymPaper) during the execution of the application.

### Installation:

#### Setup the simulation of the experiment:

https://github.com/rosin-project/metacontrol_sim/tree/MVP_world#setup-using-wstool

#### Get the ROS graph parser

```
$ cd ~/metacontrol_ws/src
$ git clone https://github.com/ipa-nhg/ros_graph_parser -b SoSymPaper
$ cd ~/metacontrol_ws/src
$ catkin_make
$ source devel/setup.bash
```

### Execute

```
$ roslaunch metacontrol_sim MVP_metacontrol_world.launch
$ rosrun ros_graph_parser java_snapshot rosin_sim.ros rosin_sim.rossystem rosin_sim rosin_sim
```

The second command will generate automatically under ~/metacontrol_ws/src/ros_graph_parser/result the files *rosin_sim.ros* and *rosin_sim.rossystem* that correspond to the  [rosin_experiment.ros](https://github.com/rosin-project/rosin-experiments/blob/master/metacontrol_sim_model/rosnodes/rosin_experiment.ros) and the [rosin_experiment.rossystem](https://github.com/rosin-project/rosin-experiments/blob/master/metacontrol_sim_model/rosin_experiment.rossystem ) of this repository.

