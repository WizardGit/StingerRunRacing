/*
 * Author: Kaiser Slocum
 */

[System.Serializable]
public class Speedstinger : Dragon
{
    public Speedstinger()
    {
        jumpForce = 1000f;
        speedForce = 20f;
        turnSpeed = 200f;

        inUse = false;
        name = "Speedstinger";

        maxDistCast = 0.1f;
        radius = 0.2f;
    }
}
