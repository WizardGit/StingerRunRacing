/*
 * Author: Kaiser Slocum
 */

[System.Serializable]
public class Dreadstrider : Dragon
{
    public Dreadstrider()
    {
        jumpForce = 1500f;
        speedForce = 15f;
        turnSpeed = 200f;

        inUse = false;
        name = "Dreadstrider";

        maxDistCast = 0.1f;
        radius = 0.2f;
    }
}
