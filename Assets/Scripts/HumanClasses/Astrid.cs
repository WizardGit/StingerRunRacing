/* Author: Kaiser Slocum
 * Last Modified: 7/12/2025
 * Purpose: Changes main attributes of the human class to describe the specifics of Astrid
 */

[System.Serializable]
public class Astrid : Human
{
    public Astrid()
    {
        jumpForce = 1000f;
        speedForce = 20f;
        turnSpeed = 180f;
        accelForce = 13f;
        waterHeight = 0.8f;

        inUse = "Buy";
        name = "Astrid";

        yLookFrom = 1.6f;
        zLookFrom = 2.6f;
    }
}
