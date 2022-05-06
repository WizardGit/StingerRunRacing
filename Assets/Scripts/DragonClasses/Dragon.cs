/*
 * Author: Kaiser Slocum
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;

[System.Serializable]
public abstract class Dragon
{
    // Variables for dragon stats
    protected float jumpForce;
    protected float speedForce;
    protected float turnSpeed;
    protected List<string> skins = new List<string>();

    // Variable for user
    protected bool inUse;
    protected string name;

    // Variables for raycasting
    protected float maxDistCast;
    protected float radius;

    public Dragon()
    {
        jumpForce = 1000f;
        speedForce = 10f;
        turnSpeed = 200f;

        inUse = false;
        name = "Dragon";

        maxDistCast = 0.1f;
        radius = 0.2f;
    }

    public float GetSpeedForce() => speedForce;
    public float GetJumpForce() => jumpForce;
    public float GetTurnSpeed() => turnSpeed;

    public void AddSkin(string skin)
    {
        skins.Add(skin);
    }
    public void SetSkin(int index, string status)
    {
        if ((index < skins.Count) && (index >= 0))
        {
            skins[index] = status;
        }
        else
        {
            Debug.Log("Index is outside the bounds of the list for ChangeSkin!");
            throw new IndexOutOfRangeException();
        }
    }
    public string GetSkin(int index)
    {
        if ((index < skins.Count) && (index >= 0))
        {
            return skins[index];
        }
        else
        {
            Debug.Log("Index is outside the bounds of the list for GetSkin!");
            throw new IndexOutOfRangeException();
        }
    }
    public int GetSkinsLength()
    {
        return skins.Count;
    }

    public void ChangeUse(bool theVar)
    {
        inUse = theVar;
    }
}
