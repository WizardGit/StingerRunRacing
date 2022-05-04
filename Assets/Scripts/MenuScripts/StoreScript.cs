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

    // Start is called before the first frame update
    void Start()
    {
        username = NameTransfer.theName;
        user = new UserSave(username);
        user.coins = 10;
        user.SaveGame();

        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            if (gameObject.transform.GetChild(i).gameObject.name == "Skins")
                skins = gameObject.transform.GetChild(0).gameObject;
            else if (gameObject.transform.GetChild(i).gameObject.name == "Text")
                text = gameObject.transform.GetChild(1).gameObject;
        }
        DisplayStats();
        DisplaySkins();
    }

    private void DisplayStats()
    {
        for (int i = 0; i < text.transform.childCount; i++)
        {
            if (text.transform.GetChild(i).gameObject.name == "Coins")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "Coins: " + user.coins.ToString();
            else if (text.transform.GetChild(i).gameObject.name == "Trophies")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "Trophies: " + user.trophies.ToString();
            else if (text.transform.GetChild(i).gameObject.name == "User")
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = "User: " + user.username.ToString();
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
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = user.speedSkins[buttonCounter++];
                    }
                    else if (child.name == "Dreadstrider")
                    {
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = user.dreadSkins[buttonCounter++];
                    }
                    
                }
            }
        }
    }
    /* TODO:
     * 1. Organize the interface! It's a mess
     * 2. If there's a better way that having three buttons per dragon, try that instead!
     * 3. Any methods hear haven't totally been thoroughly tested, so feel free to change to get stuff working!      * 
     */

    public void HandleSpeedButton(int indexSkinNumber)
    {
        HandleButton("speedstinger", indexSkinNumber, ref user.speedSkins);
    }
    public void HandleDreadButton(int indexSkinNumber)
    {
        HandleButton("dreadstrider", indexSkinNumber, ref user.dreadSkins);
    }

    private void HandleButton(string model, int indexSkinNumber, ref string[] skinsArray)
    {
        Debug.Log(skinsArray[indexSkinNumber]);
        if (skinsArray[indexSkinNumber] == "Buy")
        {
            Buy(10, model, indexSkinNumber);
        }
        else if (skinsArray[indexSkinNumber] == "Switch")
        {
            SwitchSkin(model, indexSkinNumber);
        }
        else if (skinsArray[indexSkinNumber] == "Using")
        {
            Debug.Log("You already have this skin and are using it!");
        }
        else
        {
            Debug.Log("Unrecognized skin state!");
        }
    }
    // Call this to switch to the skin at indexSkinNumber
    private void SwitchSkin(string dragonModel, int indexSkinNumber)
    {
        string[] theArray;
        if (dragonModel == "speedstinger")
        {
            theArray = user.speedSkins;
        }
        else if (dragonModel == "dreadstrider")
        {
            theArray = user.dreadSkins;
        }
        else
        {
            return;
        }

        //Double check we can switch!
        if (theArray[indexSkinNumber] == "Switch")
        {
            for (int i = 0; i < theArray.Length; i++)
            {
                if (i == indexSkinNumber)
                {
                    theArray[indexSkinNumber] = "Using";
                }
                else if (theArray[i] == "Using")
                {
                    theArray[i] = "Switch";
                }
            }
        }
        else
        {
            Debug.Log("user is already using or has not acquired this skin!");
        }
        DisplaySkins();
    }

    // Sample of what to do when a user buys something!
    private void Buy(int purchaseAmount, string dragonModel, int indexSkinNumber)
    {
        if (user.coins >= purchaseAmount)
        {
            if (dragonModel == "speedstinger")
            {
                user.speedSkins[indexSkinNumber] = "Switch";
            }
            else if (dragonModel == "dreadstrider")
            {
                user.dreadSkins[indexSkinNumber] = "Switch";
            }
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
