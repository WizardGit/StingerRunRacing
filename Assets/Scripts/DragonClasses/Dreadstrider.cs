/* Author: Kaiser Slocum
 * Last Modified: 5/22/2025
 * Purpose: Changes main attributes of the dragon class to describe the specifics of a dreadstrider
 */

[System.Serializable]
public class Dreadstrider : Dragon
{
    public Dreadstrider()
    {
        jumpForce = 1000f;
        speedForce = 20f;
        turnSpeed = 180f;
        accelForce = 13f;
        waterHeight = 0.8f;

        inUse = "Buy";
        name = "Dreadstrider";

        yLookFrom = 1.6f;
        zLookFrom = 2.6f;
    }
}
