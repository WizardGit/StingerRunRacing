/* Author: Kaiser Slocum
 * Last Modified: 5/22/2025
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
        waterHeight = 0f;

        inUse = "Using";
        name = "Speedstinger";

        yLookFrom = 1.5f;
        zLookFrom = 1.5f;
    }
}
