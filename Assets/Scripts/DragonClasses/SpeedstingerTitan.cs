/* Author: Kaiser Slocum
 * Last Modified: 5/22/2025
 * Purpose: Describes main attributes of the titan speedstinger class of dragon
 */

[System.Serializable]
public class SpeedstingerTitan : Speedstinger
{
    public SpeedstingerTitan()
    {
        jumpForce = 1200f;
        speedForce = 25f;
        turnSpeed = 200f;
        accelForce = 12f;
        waterHeight = 0f;

        inUse = "Buy";
        name = "SpeedstingerTitan";

        yLookFrom = 1.6f;
        zLookFrom = 1.5f;
    }
}
