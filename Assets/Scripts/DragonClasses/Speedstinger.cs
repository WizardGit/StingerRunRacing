/* Author: Kaiser Slocum
 * Last Modified: 6/2/2022
 * Purpose: Changes main attributes of the dragon class to describe the specifics of a speedstinger
 */

[System.Serializable]
public class Speedstinger : Dragon
{
    public Speedstinger()
    {
        jumpForce = 1300f;
        speedForce = 18f;
        turnSpeed = 200f;
        accelForce = 17f;

        inUse = "Using";
        name = "Speedstinger";

        yLookFrom = 1.5f;
        zLookFrom = 1.5f;
    }
}
