/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
 */

[System.Serializable]
public class Speedstinger : Dragon
{
    public Speedstinger()
    {
        jumpForce = 1000f;
        speedForce = 30f;
        turnSpeed = 200f;
        accelForce = 10f;

        inUse = "Using";
        name = "Speedstinger";
    }
}
