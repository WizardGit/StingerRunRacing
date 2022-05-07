/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
 */

[System.Serializable]
public class Dreadstrider : Dragon
{
    public Dreadstrider()
    {
        jumpForce = 1500f;
        speedForce = 15f;
        turnSpeed = 200f;

        inUse = "Buy";
        name = "Dreadstrider";
    }
}
