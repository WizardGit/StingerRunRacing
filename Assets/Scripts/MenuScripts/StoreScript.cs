/*
 * Author: Kaiser Slocum
 * Last Modified: 5/6/2022
 */

using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using TMPro;

public class StoreScript : MonoBehaviour
{
    public UserSave user;
    private string username;

    private GameObject skins;
    private GameObject text;

    private Dragon speedDerg;
    private Dragon dreadDerg;

    // Start is called before the first frame update
    void Start()
    {
        username = NameTransfer.theName;
        user = new UserSave(username);
        user.coins = 2000;

        speedDerg = user.dragons[0];
        dreadDerg = user.dragons[1];
        user.SaveGame();
        Debug.Log(user.coins.ToString());

        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            if (gameObject.transform.GetChild(i).gameObject.name == "Skins")
                skins = gameObject.transform.GetChild(1).gameObject;
            else if (gameObject.transform.GetChild(i).gameObject.name == "Text")
                text = gameObject.transform.GetChild(2).gameObject;
        }
        DisplayStats();
        DisplaySkins();
        DisplayPrices();
        DisplayUses();
    }

    private void DisplayStats()
    {
        Debug.Log(text.transform.childCount.ToString());
        Debug.Log(user.coins.ToString());
        for (int i = 0; i < text.transform.childCount; i++)
        {
            if (text.transform.GetChild(i).gameObject.name == "Coins")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "Coins: " + user.coins.ToString();
            else if (text.transform.GetChild(i).gameObject.name == "Trophies")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "Trophies: " + user.trophies.ToString();
            else if (text.transform.GetChild(i).gameObject.name == "User")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "User: " + user.username.ToString();
            else
                Debug.Log("epicfailure");
        }
    }
    private void DisplaySkins()
    {
        for (int i = 0; i < skins.transform.childCount; i++)
        {
            GameObject child = skins.transform.GetChild(i).gameObject;
            int buttonCounter = 0;

            for (int j = 0; j < child.transform.childCount; j++)
            {
                GameObject childOfChild = child.transform.GetChild(j).gameObject;                

                if (childOfChild.name == "Button")
                {                    
                    if (child.name == "Speedstinger")
                    {
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = speedDerg.GetSkin(buttonCounter++);
                    }
                    else if (child.name == "Dreadstrider")
                    {
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = dreadDerg.GetSkin(buttonCounter++);
                    }                    
                }
            }
        }
    }
    private void DisplayUses()
    {
        for (int i = 0; i < skins.transform.childCount; i++)
        {
            GameObject child = skins.transform.GetChild(i).gameObject;

            for (int j = 0; j < child.transform.childCount; j++)
            {
                GameObject childOfChild = child.transform.GetChild(j).gameObject;

                if (childOfChild.name == "UseDerg")
                {
                    if (child.name == "Speedstinger")
                    {
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = speedDerg.GetUse();
                    }
                    else if (child.name == "Dreadstrider")
                    {
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = dreadDerg.GetUse();
                    }
                }
            }
        }
    }
    private void DisplayPrices()
    {
        for (int i = 0; i < skins.transform.childCount; i++)
        {
            GameObject child = skins.transform.GetChild(i).gameObject;
            int buttonCounter = 0;

            for (int j = 0; j < child.transform.childCount; j++)
            {
                GameObject childOfChild = child.transform.GetChild(j).gameObject;

                if (childOfChild.name == "Price")
                {
                    Debug.Log("here!");
                    if (child.name == "Speedstinger")
                    {
                        childOfChild.transform.GetComponent<TextMeshProUGUI>().text = speedDerg.GetSkinPrice(buttonCounter++).ToString();
                    }
                    else if (child.name == "Dreadstrider")
                    {
                        childOfChild.transform.GetComponent<TextMeshProUGUI>().text = dreadDerg.GetSkinPrice(buttonCounter++).ToString();
                    }
                }
            }
        }
    }    

    public void HandleSpeedDergButton()
    {
        HandleDergButton(speedDerg);
    }
    public void HandleDreadDergButton()
    {
        HandleDergButton(dreadDerg);
    }
    private void HandleDergButton(Dragon derg)
    {
        if (derg.GetUse() == "Buy")
        {
            BuyDerg(derg.GetPurchasePrice(), derg);
        }
        else if (derg.GetUse() == "Switch")
        {
            SwitchDerg(speedDerg, dreadDerg);
        }
        else if (derg.GetUse() == "Using")
        {
            Debug.Log("You already have this skin and are using it!");
        }
        else
        {
            Debug.Log("Unrecognized skin state!");
        }
    }

    public void HandleSpeedButton(int indexSkinNumber)
    {
        HandleButton(indexSkinNumber, speedDerg);
    }
    public void HandleDreadButton(int indexSkinNumber)
    {
        HandleButton(indexSkinNumber, dreadDerg);
    }
    private void HandleButton(int indexSkinNumber, Dragon derg)
    {
        if (derg.GetSkin(indexSkinNumber) == "Buy")
        {
            Buy(derg.GetSkinPrice(indexSkinNumber), derg, indexSkinNumber);
        }
        else if (derg.GetSkin(indexSkinNumber) == "Switch")
        {
            SwitchSkin(derg, indexSkinNumber);
        }
        else if (derg.GetSkin(indexSkinNumber) == "Using")
        {
            Debug.Log("You already have this skin and are using it!");
        }
        else
        {
            Debug.Log("Unrecognized skin state!");
        }
    }
    
    private void SwitchDerg(Dragon derg1, Dragon derg2)
    {
        if ((derg1.GetUse() == "Buy") || (derg2.GetUse() == "Buy"))
        {
            Debug.Log("ERROR! Can't switch when one dragon still needs to be bought!");
        }
        else if (derg1.GetUse() == "Switch")
        {
            derg1.ChangeUse("Using");
            derg2.ChangeUse("Switch");
        }
        else if (derg2.GetUse() == "Switch")
        {
            derg1.ChangeUse("Switch");
            derg2.ChangeUse("Using");
        }
        DisplayUses();
    }
    // Call this to switch to the skin at indexSkinNumber
    private void SwitchSkin(Dragon derg, int indexSkinNumber)
    {
        //Double check we can switch!
        if (derg.GetSkin(indexSkinNumber) == "Switch")
        {
            for (int i = 0; i < derg.GetSkinsLength(); i++)
            {
                if (i == indexSkinNumber)
                {
                    derg.SetSkin(indexSkinNumber, "Using");
                }
                else if (derg.GetSkin(i) == "Using")
                {
                    derg.SetSkin(i, "Switch");
                }
            }
        }
        else
        {
            Debug.Log("user is already using or has not acquired this skin!");
        }
        DisplaySkins();
    }

    private void BuyDerg(int purchaseAmount, Dragon derg)
    {
        if (user.coins >= purchaseAmount)
        {
            derg.ChangeUse("Switch");
            // Complete the transaction and save what was done!
            user.coins -= purchaseAmount;
            user.SaveGame();
            // Refresh the screen
            DisplayStats();
            DisplaySkins();
        }
        else
        {
            Debug.Log("Not enough money!");
        }
        DisplayUses();
    }
    // Sample of what to do when a user buys something!
    private void Buy(int purchaseAmount, Dragon derg, int indexSkinNumber)
    {
        if (user.coins >= purchaseAmount)
        {
            derg.SetSkin(indexSkinNumber, "Switch");

            // Complete the transaction and save what was done!
            user.coins -= purchaseAmount;
            user.SaveGame();
            // Refresh the screen
            DisplayStats();
            DisplaySkins();
        }
        else
        {
            Debug.Log("Not enough money!");
        }
    }
}
