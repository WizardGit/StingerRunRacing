/* Author: Kaiser Slocum
 * Last Modified: 7/12/2025
 * Purpose: Changes main attributes of the human class to describe the specifics of Heather
 */

[System.Serializable]
public class Heather : Human
{
    public Heather()
    {
        jumpForce = 1000f;
        speedForce = 20f;
        turnSpeed = 180f;
        accelForce = 13f;
        waterHeight = 0.8f;

        inUse = "Buy";
        name = "Heather";

        yLookFrom = 1.6f;
        zLookFrom = 2.6f;
    }
}
