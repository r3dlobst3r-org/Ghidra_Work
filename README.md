# Ghidra Work
We are working to increase Electronic Power Steering (EPS) torque.

There are two paths to this goal:
1. Modify the EPS motor firmware
2. Manipulate messages going to the EPS motor

This repo will serve as an archive of ongoing work.

To Do:

Path 1. Modify the EPS motor firmware
  Understand torque tables and torque table lookup functions
  Find final torque output (should be sent to a motor controller through some i/o port register)
      Is there a simple multiplier we can increase once the torque gets past all of the limit clamps? (there are several torque clamps)
  Find firmware checksum to update for mods (might be in UDS stuff)
  Find encryption keys for making .RWD (should be in UDS stuff)
  Write byte lookup to make .RWD? (if Gregs tool does not work)
  
Path 2. Manipulate messages going to the EPS motor  

  What happens in can_xxx_fn2? every message has a fn2, they call can_processing1 and 2, sometimes do other stuff
  What is can_??? (maybe related to UDS?)
  What does can_156 do? 2 bytes and 3 bits are read from this, and fed into several functions. It appears nowhere in Cabana.
  What do the new signals in can_0e4 do? Flags at b38 and b39 seem interesting
