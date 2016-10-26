# gradient_descent_simulation
TL;DR
This is a simulation of a seeker robot performing a greedy depth-first-search to reach a goal robot using gradient descent.

Long Description:
This is the code portion of a summfdkslaer research project that I completed as an AMGEN Scholar at Harvard University from Jun - Aug 2016.

The project is called “Autonomous Routing through a Smart Material” and I made an algorithm that would allow a seeker robot to autonomously form a shortest-path to a goal robot by following a gradient.  The first half of the project was about testing the algorithm on physical robots and in the second half I wrote a simulation of the problem in Netlogo agent-based software.  That is the code you will find here.


This simulation allows users to observe a seeker robot finding the shortest path to a goal robot.  Paths are calculated in manhattan distances (ie. no diagonal moves are allowed).  Users can add multiple goal locations, and the seeker will always go to the closest one.  Users can also add barriers, and multiple seekers.


Set-Up:

1.  If you have not yet downloaded Netlogo, please find it here:  https://ccl.northwestern.edu/netlogo/download.shtml and follow thier download instructions.1.

2.  Go to the menu path File > Open > filename.

3.  When it loads, the interface should have two buttons, 4 sliders, one drop-down menu, and a large blank (black) window.
Set the sliders to “num-seeds” = 1, “num-seekers” = 1, “num-obstacles” = 5, and “obstacle-height” = 21.  Select a color from the “gradient-color” drop-down menu and then click the “setup” button.

4.  Now the simulation window should have loaded the simulation.

5.  Press “go” twice.  Once to start the simulation, and once to stop it.

6.  Now the seeker robot speeds across the screen leaving behind a yellow trail which is one of the possible shortest paths to the goal.
You can change the configuration of the problem setup using the sliders.  Remember to press “setup” each time before you press “go.”


This simulation is pretty static, but I will be creating a more dynamic one over the next 6 months for my Senior Project, which you can find here.





