/*
 * Author: Kaiser Slocum
 * Last Modified: 5/24/2022
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
    protected float accelForce;

    // Lists of skins available
    protected List<string> skins;
    protected List<int> skinsPrices;

    // Price to buy the dragon
    protected int purchasePrice;

    // Variable for user
    protected string inUse;
    protected string name;

    // Variables for raycasting
    protected float maxDistCast;
    protected float radius;

    public Dragon()
    {
        // Default stats
        jumpForce = 1000f;
        speedForce = 10f;
        turnSpeed = 200f;
        accelForce = 5f;

        name = "Dragon";

        maxDistCast = 0.09f;
        radius = 0.3f;
        skins = new List<string>();
        skinsPrices = new List<int>();
        inUse = "Buy";
        purchasePrice = 300;
    }

    public float GetSpeedForce() => speedForce;
    public float GetJumpForce() => jumpForce;
    public float GetTurnSpeed() => turnSpeed;
    public float GetAccelForce() => accelForce;

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
