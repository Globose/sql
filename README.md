## Main loop default mode
After the setup phase the robot will enter the main loop. The program will repeat the following:
* Try to pickup an item at the pickup location

* If there is an item at the pickup location, the robot will read the color of the item and determine the location that matches the color best. Then the robot will move to that location and drop off the item there. 

* If there is no item at the pickup location, the robot will wait for 3 seconds and then look for an item again.


## Main loop two robots
After the setup phase the robot will enter the main loop. The client robot will be in its resting position. The program will repeat the following:

* The server robot tries to pickup and item at the pickup location.

* If there is no item at the pickup location, the server robot will wait for 3 seconds and then look for an item again.

* If there is an item at the pickup location, the server robot will read its color and determine which location is closest to the color. 

  * If the location belongs to the client robot, the server robot will drop the item off at the shared position, then return to the pickup location and wait there, while the client robot picks up the item and places it at the given location. 

  * If the location belongs to the server robot, the server robot will drop off the item at the given location.
