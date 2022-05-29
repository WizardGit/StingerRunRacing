/*
 * Author: Kaiser Slocum
 * Last Modified: 5/29/2022
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

        inUse = "Buy";
        name = "SpeedstingerTitan";
    }
}
