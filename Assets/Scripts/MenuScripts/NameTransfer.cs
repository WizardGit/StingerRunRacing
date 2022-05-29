/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 5/28/2022
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

    void Start()
    {
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
        UserSave user = new UserSave(theName);
        user.DeleteUser();
    }
    public void ResetLeaderboard()
    {
        LeaderboardSave ledSave = new LeaderboardSave();
        ledSave.ResetLeaderboard();
    }
}
