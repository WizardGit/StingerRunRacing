/* Author: Kaiser Slocum
 * Last Modified: 5/22/2025
 * Purpose: Describes main attributes of the baby speedstinger class of dragon
 */

[System.Serializable]
public class SpeedstingerBaby : Speedstinger
{
    public SpeedstingerBaby()
    {
        jumpForce = 700f;
        speedForce = 25f;
        turnSpeed = 200f;
        accelForce = 7f;
        waterHeight = 0f;

        inUse = "Buy";
        name = "SpeedstingerBaby";

        yLookFrom = 0.8f;
        zLookFrom = 0.8f;
    }
}
