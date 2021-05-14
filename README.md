# Mass balance climate controlled chambers for eco-physiological research

Manipulating the environment while at the same time measuring key parameters is central to many eco-physiological experiments. Experiments often use climate controlled chambers to change environmental parameters outside their normal range. Often these experiments rely on dedicated hardware, or even buildings, to provide the fine grained control needed to execute these tasks. Smaller scale mobile chambers exist, but fitting equipment is often difficult. Here, we present the description of simple climate controlled chambers outfitted for mass balanced based eco-physiological research. We describe a parts list as well as code to implement a setup which has only centimeters to spare, optimizing space use and minimizing cost.

## Cost effective

Although we acknowledge that the growth chambers carry a considerable cost. However, the reuse of small lab based growth chambers, normally reserved for smaller growth medium experiments, within the context of seedling and sapling research provides cost savings and a flexibility to researchers not available in brick and mortar setups. A bill of materials is provided [here](https://raw.githubusercontent.com/khufkens/growth_chamber_protocol/main/docs/BOM.pdf)

## Setup

The setup is built around the MD1400 Climate chambers by Snijder Labs, these units provide an interior space which can accomodate eight (8) Kern EOC 10K-4 scales. Together with high power 120W growth lamps these form the core of the mass balance measurement setup.

![](https://raw.githubusercontent.com/khufkens/growth_chamber_protocol/main/docs/images/IMG_4523.JPG)

### logging

Kern EOC 10K-4 scales were selected because they interface easily using a RS232 (serial) connection (a feature required for automated logging, and not always available). Logging is provided using open hardware, a raspberry pi. The serial signal is translated to USB using a RS232 to USB converter with four connections. A schematic wiring diagram of our setup is provided [here](https://github.com/khufkens/growth_chamber_protocol/blob/main/docs/images/kern_setup.png)

#### Software

When fully setup and connected a python script is run to log weight and other variables (if additional sensors are connected) on a regular schedule. We've included the required scripts to log weights on the raspberry pi (scripts can be found in the python directory). In addition we've included callibration data as used in our setup and code to evaluate consistency throughout the chamber. This code can provide a good starting point to construct your own baselines / validation curves.

# Acknowledgements

This project was supported by the Marie Skłodowska-Curie Action (H2020 grant 797668).