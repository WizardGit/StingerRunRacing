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
        speedForce = 20f;
        turnSpeed = 200f;

        inUse = false;
        name = "Speedstinger";
    }
}
