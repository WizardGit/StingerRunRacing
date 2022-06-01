/* Author: Kaiser Slocum
 * Last Modified: 6/1/2022
 * Purpose: Describes main attributes of the dreadstrider class of dragon
 */

[System.Serializable]
public class Dreadstrider : Dragon
{
    public Dreadstrider()
    {
        jumpForce = 1500f;
        speedForce = 15f;
        turnSpeed = 200f;
        accelForce = 15f;

        inUse = "Buy";
        name = "Dreadstrider";

        yLookFrom = 1.6f;
        zLookFrom = 2.6f;
    }
}
