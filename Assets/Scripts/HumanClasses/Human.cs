/* Author: Kaiser Slocum
 * Last Modified: 7/12/2025
 * Purpose: Describes attributes of the human class
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public abstract class Human
{
    // Variables for dragon stats
    protected float jumpForce;
    protected float speedForce;
    protected float turnSpeed;
    protected float accelForce;
    protected float waterHeight;

    // Variable for theSave
    protected string inUse;
    protected string name;

    // Variables for raycasting
    protected float maxDistCast;
    protected float radius;

    // Variables for camera look
    protected float yLookFrom;
    protected float zLookFrom;

    public Human()
    {
        // Default stats
        jumpForce = 1000f;
        speedForce = 10f;
        turnSpeed = 200f;
        accelForce = 5f;
        waterHeight = 0.6f;

        name = "Human";

        maxDistCast = 0.09f;
        radius = 0.3f;
        inUse = "Buy";

        yLookFrom = 0.0f;
        zLookFrom = 0.0f;
    }

    public float GetSpeedForce() => speedForce;
    public float GetJumpForce() => jumpForce;
    public float GetTurnSpeed() => turnSpeed;
    public float GetAccelForce() => accelForce;
    public float GetWaterHeight() => waterHeight;

    public float GetYLookFrom() => yLookFrom;
    public float GetZLookFrom() => zLookFrom;

    public string GetName() => name;
    public float GetMaxDistCast() => maxDistCast;
    public float GetRadius() => radius;
    public string GetUse() => inUse;

    public void ChangeUse(string theVar)
    {
        inUse = theVar;
    }      
}
