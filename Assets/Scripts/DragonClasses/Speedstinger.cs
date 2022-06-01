/* Author: Kaiser Slocum
 * Last Modified: 6/1/2022
 * Purpose: Describes main attributes of the speedstinger class of dragon
 */

[System.Serializable]
public class Speedstinger : Dragon
{
    public Speedstinger()
    {
        jumpForce = 1000f;
        speedForce = 20f;
        turnSpeed = 200f;
        accelForce = 10f;

        inUse = "Using";
        name = "Speedstinger";

        yLookFrom = 1.5f;
        zLookFrom = 1.5f;
    }
}
