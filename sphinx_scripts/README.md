# Sphinx-scripts #

This directory stores 2 bash scripts that help developer install and launch simulator ([parrot-sphinx](https://developer.parrot.com/docs/sphinx/index.html)) for bebop2.

## Installation ##

### Ubuntu 16.04 (xenial) ###

> #### Warning ####
> This script only works for Ubuntu 16.04 (xenial) currently.

Run the following command (root permission required):

```bash
chmod +x ./*.sh
./install.sh
```

This will midify your wifi configuration so as to run everything properly. Also the core package `parrot-sphinx` will be equipped.

### Other distribution ###

Please refer to the [official installation procedure](https://developer.parrot.com/docs/sphinx/installation.html).

## Usage ##

1. Launch the simulator with command
   ```bash
   ./launch.sh
   ```
2. Run the `bebop_driver` with roslaunch
   ```bash
   roslaunch bebop_driver bebop_node_sphinx.launch
   ```
