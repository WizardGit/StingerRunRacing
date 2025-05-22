/* Author: Kaiser Slocum
 * Last Modified: 5/22/2025
 * Purpose: Describes attributes of the dragon class
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public abstract class Dragon
{
    // Variables for dragon stats
    protected float jumpForce;
    protected float speedForce;
    protected float turnSpeed;
    protected float accelForce;
    protected float waterHeight;

    // Lists of skins available
    protected List<string> skins;
    protected List<int> skinsPrices;

    // Price to buy the dragon
    protected int purchasePrice;

    // Variable for theSave
    protected string inUse;
    protected string name;

    // Variables for raycasting
    protected float maxDistCast;
    protected float radius;

    // Variables for camera look
    protected float yLookFrom;
    protected float zLookFrom;

    public Dragon()
    {
        // Default stats
        jumpForce = 1000f;
        speedForce = 10f;
        turnSpeed = 200f;
        accelForce = 5f;
        waterHeight = 0.6f;

        name = "Dragon";

        maxDistCast = 0.09f;
        radius = 0.3f;
        skins = new List<string>();
        skinsPrices = new List<int>();
        inUse = "Buy";
        purchasePrice = 300;

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

    public int GetPurchasePrice() => purchasePrice;
    public string GetName() => name;
    public float GetMaxDistCast() => maxDistCast;
    public float GetRadius() => radius;
    public int GetSkinsPricesLength() => skinsPrices.Count;
    public string GetUse() => inUse;

    public void ChangeUse(string theVar)
    {
        inUse = theVar;
    }   

    // Add another skin to the dragon skin list
    public void AddSkin(string skin)
    {
        skins.Add(skin);
    }
    // set the usage status of the skin at index in the dragon skin list 
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
    // Get the skin at index from the dragon skin list
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
    // Get the number of possible dragon skins
    public int GetSkinsLength()
    {
        return skins.Count;
    }
    // Add the price of the corresponding skin in the dragon skin list
    public void AddSkinPrice(int price)
    {
        skinsPrices.Add(price);
    }
    // Change the skin's price at the index
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
    // Get the skin's price at the specified index
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
}
