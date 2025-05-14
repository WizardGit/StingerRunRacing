/*
 * Authors: Kaiser Slocum, Sofi Vinas
 * Last Modified: 5/14/2025
 * Purpose: Statically store the current theSave's username.  Because it is static, the theSave's username can be access from all other scenes
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class NameTransfer : MonoBehaviour
{
    public static string theName = "Guest";
    public GameObject inputField;

    //the object we'll display in the game
    public GameObject textDisplay;
    public GameObject mainmenu;

    private SaveGame theSave;

    void Start()
    {
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        if (SceneManager.GetActiveScene() == SceneManager.GetSceneByName("Menu"))
        {
            textDisplay.GetComponent<TMPro.TextMeshProUGUI>().text = "Current User: " + theName;
        }
    }

    //storing name in a button
    public void StoreName()
    {
        theName = inputField.GetComponent<TMPro.TextMeshProUGUI>().text;
        textDisplay.GetComponent<TMPro.TextMeshProUGUI>().text = "Welcome " + theName;
    }
    public void ResetName()
    {
        theSave.ResetUser();
        mainmenu.GetComponent<MainMenu>().CheckLevelAvailability();
    }
    public void ResetLeaderboard()
    {
        theSave.ledSave.ResetLeaderboard();
    }    
}
