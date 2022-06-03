/*
 * Authors: Kaiser Slocum, Sofi Vinas
 * Last Modified: 6/2/2022
 * Purpose: Allow users to purchase new skins and acquire a different dragon racer
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.SceneManagement;

public class StoreScript : MonoBehaviour
{
    // Various objects needed for canvas
    public UserSave user;
    public InputField coinsField;
    public AudioSource coinsAudio;
    public AudioSource evilLaugh;
    public ParticleSystem particleBlast;
    public TextMeshProUGUI dragonStatsText;
    public GameObject warningCanvas;

    // Variable representing children of canvas element
    private GameObject skins;
    private GameObject text;
    private float timer = 0.0f;
    private bool messageOn = false;

    // Lists of skins for dragons
    public List<Material> dreadMaterials;
    public List<Material> speedMaterials;

    private void Start()
    {
        user = new UserSave(NameTransfer.theName);

        for (int i = 0; i < gameObject.transform.childCount; i++)
        {
            if (gameObject.transform.GetChild(i).gameObject.name == "Skins")
                skins = gameObject.transform.GetChild(1).gameObject;
            else if (gameObject.transform.GetChild(i).gameObject.name == "Text")
                text = gameObject.transform.GetChild(2).gameObject;
        }
        DisplayStats();
        DisplaySkins();
        DisplayUses();
        LoadDragonsSkin();
    }

    private void FixedUpdate()
    {
        if (messageOn == true)
            timer += Time.deltaTime;
        if (timer >= 2.0f)
        {
            timer = 0;
            warningCanvas.SetActive(false);
        }
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
            else
            {
                Dragon derg = user.dragons[user.IndexOfDragonInUse()];
                text.transform.GetChild(i).gameObject.GetComponent<TextMeshProUGUI>().text = 
                    "Dragon STATS:" +
                    "\nJump Power: " + derg.GetJumpForce() + 
                    "\nSpeed: " + derg.GetSpeedForce() + 
                    "\nAcceleration: " + derg.GetAccelForce() + 
                    "\nTurn Rate: " + derg.GetTurnSpeed();
            }
                
        }
    }
    // Displays the skin uses and prices for the dragons
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
                    childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = user.dragons[i].GetSkin(buttonCounter);
                    if (user.dragons[i].GetSkin(buttonCounter) == "Buy")
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text += " " + user.dragons[i].GetSkinPrice(buttonCounter).ToString();
                    buttonCounter++;
                }
            }
        }
    }
    // Displays the use and price of the dragons
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
                    childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text = user.dragons[i].GetUse();
                    if (user.dragons[i].GetUse() == "Buy")
                        childOfChild.transform.GetChild(0).GetComponent<TextMeshProUGUI>().text += " " + user.dragons[i].GetPurchasePrice().ToString();
                }
            }
        }
    }

    // Handles a dragon button
    public void HandleDergButton(int i)
    {
        string dergUse = user.dragons[i].GetUse();
        if (dergUse == "Buy")
            BuyDerg(i);
        else if (dergUse == "Switch")
            SwitchDerg(i);
        else if (dergUse == "Using")
            Debug.Log("You already have this skin and are using it!");
        else
            Debug.Log("Unrecognized skin state!");
    }
    // Switches to the dragon (at dragonIndex)
    private void SwitchDerg(int dragonIndex)
    {
        user.UseDragon(dragonIndex);
        DisplayUses();
        DisplayStats();
        LoadDragonsSkin();
    }
    // Buys the dragon (at dragonIndex)
    private void BuyDerg(int dragonIndex)
    {
        if (user.trophies >= user.dragons[dragonIndex].GetPurchasePrice())
        {
            user.dragons[dragonIndex].ChangeUse("Switch");
            // Complete the transaction and save what was done!
            user.trophies -= user.dragons[dragonIndex].GetPurchasePrice();
            user.SaveUser();
            // Refresh the screen
            DisplayStats();
            DisplaySkins();
            DisplayUses();
            coinsAudio.Play();
            particleBlast.Play();
        }
        else
        {
            warningCanvas.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = "You do not have enough trophies!";
            warningCanvas.SetActive(true);
            messageOn = true;
        }
    }

    // Handles a skin button
    public void HandleSkinButton(int purchaseNumber)
    {
        int dragonIndex = (int)MathF.Round(purchaseNumber / 10,0);
        int skinIndex = purchaseNumber % 10;
        string skinUse = user.dragons[dragonIndex].GetSkin(skinIndex);        

        if (skinUse == "Buy")
            BuySkin(dragonIndex, skinIndex);
        else if (skinUse == "Switch")
            SwitchSkin(dragonIndex, skinIndex);
        else if (skinUse == "Using")
            Debug.Log("You already have this skin and are using it!");
        else
            Debug.Log("Unrecognized skin state!");
    }    
    // Switches dragon (at dragonIndex)'s skin to that at skinIndex
    private void SwitchSkin(int dragonIndex, int skinIndex)
    {
        Dragon derg = user.dragons[dragonIndex];
        //Double check we can switch!
        if (derg.GetSkin(skinIndex) == "Switch")
        {
            derg.SetSkin(skinIndex, "Using");

            for (int i = 0; i < derg.GetSkinsLength(); i++)
            {
                if ((derg.GetSkin(i) == "Using") && (i != skinIndex))
                    derg.SetSkin(i, "Switch");
            }

            user.SaveUser();
            DisplaySkins();
            LoadDragonsSkin();
        }
        else
            Debug.Log("user is already using or has not acquired this skin!");
    }
    // Buys dragon (at dragonIndex)'s skin at skinIndex
    private void BuySkin(int dragonIndex, int skinIndex)
    {
        if (user.coins >= user.dragons[dragonIndex].GetSkinPrice(skinIndex))
        {
            user.dragons[dragonIndex].SetSkin(skinIndex, "Switch");

            // Complete the transaction and save what was done!
            user.coins -= user.dragons[dragonIndex].GetSkinPrice(skinIndex);
            user.SaveUser();
            // Refresh the screen
            DisplayStats();
            DisplaySkins();
            coinsAudio.Play();
        }
        else
        {
            warningCanvas.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = "You do not have enough coins!";
            warningCanvas.SetActive(true);
            messageOn = true;
        }            
    }

    public void GoToMainMenu()
    {
        SceneManager.LoadScene("Menu");
    }

    // Handles the cheat codes
    public void HandleGreed()
    {        
        string s = coinsField.text;
        if (s == "coins")
        {
            user.coins += 200;
            user.SaveUser();
            evilLaugh.Play();
        }
        else if (s == "trophies")
        {
            user.trophies += 200;
            user.SaveUser();
            evilLaugh.Play();
        }
        DisplayStats();      
    }

    // Places the correct dragon and its correct skin on the canvas
    private void LoadDragonsSkin()
    {
        int modelToUse = 0;
        string nameToUse = "";
        for (int i = 0; i < user.dragons.Count; i++)
        {
            if (user.dragons[i].GetUse() == "Using")
            {
                modelToUse = i;
                nameToUse = user.dragons[i].GetName();
            }
        }
        for (int i = 0; i < gameObject.transform.GetChild(6).gameObject.transform.childCount; i++)
        {
            if (i == modelToUse)
            {
                gameObject.transform.GetChild(6).gameObject.transform.GetChild(i).gameObject.SetActive(true);
            }
            else
            {
                gameObject.transform.GetChild(6).gameObject.transform.GetChild(i).gameObject.SetActive(false);
            }
        }
        

        // Load the correct skin!
        for (int i = 0; i < user.dragons[modelToUse].GetSkinsLength(); i++)
        {
            if (user.dragons[modelToUse].GetSkin(i) == "Using")
            {
                if (nameToUse == "Speedstinger")
                {
                    gameObject.transform.GetChild(6).gameObject.transform.GetChild(modelToUse).gameObject.transform.GetChild(0).gameObject.GetComponent<Renderer>().material = speedMaterials[i];
                }
                else if (nameToUse == "Dreadstrider")
                {
                    gameObject.transform.GetChild(6).gameObject.transform.GetChild(modelToUse).gameObject.transform.GetChild(0).gameObject.GetComponent<Renderer>().material = dreadMaterials[i];
                }
                
            }
        }
    }
}
