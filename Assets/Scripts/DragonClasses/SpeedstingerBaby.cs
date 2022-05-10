/*
 * Author: Kaiser Slocum
 * Last Modified: 5/10/2022
 */

[System.Serializable]
public class SpeedstingerBaby : Speedstinger
{
    public SpeedstingerBaby()
    {
        jumpForce = 700f;
        speedForce = 25f;
        turnSpeed = 200f;

        inUse = "Buy";
        name = "SpeedstingerBaby";
    }
}
