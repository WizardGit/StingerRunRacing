/*
 *Author: Kaiser Slocum
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LeaderboardScript : MonoBehaviour
{
    public void BackMenuGame()
    {
        SceneManager.LoadScene("Menu");
    }
    public void ToggleLeaderboard()
    {
        if (gameObject.transform.GetChild(1).gameObject.activeSelf == true)
        {
            gameObject.transform.GetChild(1).gameObject.SetActive(false);
            gameObject.transform.GetChild(2).gameObject.SetActive(true);
        }
        else
        {
            gameObject.transform.GetChild(1).gameObject.SetActive(true);
            gameObject.transform.GetChild(2).gameObject.SetActive(false);
        }
    }
}
