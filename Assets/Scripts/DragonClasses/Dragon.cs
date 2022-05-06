/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
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
    protected List<string> skins;
    protected List<int> skinsPrices;

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
        radius = 0.3f;
        skins = new List<string>();
        skinsPrices = new List<int>();                
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

    public void AddSkinPrice(int price)
    {
        skinsPrices.Add(price);
    }
    public void SetSkinPrice(int index, int price)
    {
        if ((index < skinsPrices.Count) && (index >= 0))
        {
            skinsPrices[index] = price;
        }
        else
        {
            Debug.Log("Index is outside the bounds of the list for ChangeSkin!");
            throw new IndexOutOfRangeException();
        }
    }
    public int GetSkinPrice(int index)
    {
        if ((index < skinsPrices.Count) && (index >= 0))
        {
            return skinsPrices[index];
        }
        else
        {
            Debug.Log("Index is outside the bounds of the list for GetSkin!");
            throw new IndexOutOfRangeException();
        }
    }
    public int GetSkinsPricesLength()
    {
        return skinsPrices.Count;
    }

    public void ChangeUse(bool theVar)
    {
        inUse = theVar;
    }
    public bool GetUse()
    {
        return inUse;
    }
    public string GetName() => name;

    public float GetMaxDistCast() => maxDistCast;
    public float GetRadius() => radius;
}
