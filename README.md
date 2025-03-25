[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/gbHItYk9)
## Project 00
### NeXTCS
### Period: 10
## Name0: Benjamin Chin
## Name1: Jason Xiao
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: orbCollision

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

F = $`(k*q*Q)/r^2`$

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - mass
  - velocity

- Does this force require any new constants, if so what are they and what values will you try initially?
  - time with an initial value of 0.1 seconds

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - time will be a float

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - other orbs

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - no

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

We will create eight orbs at the center of the screen with a fixed orb located at in between the other eight orbs called sun and calculate the attraction force for each orb in the array based off the orb in the center.

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

There will be a four regular orbs created randomly around the screen and a fixed orb in the middle of the screen and the beginning of the array. Each orb will have a spring attatched to each of the orbs next to it. The orbs should bounce around the screen with each orb pulling on the orbs next to it through the springs attatched between the orbs.

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

There will be five orbs created at the top of the screen. There will be "water" from the middle of the screen to the bottom. The orbs will experience drag force while in the water.

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

There will be five orbs spawned randomly around the screen. They will be given velocities with the same magnitude but a random direction. When the orbs collide they should bounce off each other instead of overlapping.

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

The simulation will have earth gravity, collision, and drag force. The orbs will be created randomly on the screen with velocities of the same magnitude but random directions. There will still be "water" covering the bottom half of the screen and orbs can spawn in the water.

