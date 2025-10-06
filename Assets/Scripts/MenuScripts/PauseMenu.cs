/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 10/6/2025
 * Purpose: Control for buttons on the Pause Menu
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class PauseMenu : MonoBehaviour
{
    public static bool isPaused = false;
    public GameObject miniP;

    // miniP is our GameObject for the Pause Menu UI
    // Start is called before the first frame update
    void Start()
    {
        miniP = gameObject.transform.GetChild(0).gameObject;
        // miniP.call whatever sound function
        miniP.SetActive(false);
    }

    public void PauseGame()
    {
        miniP.SetActive(true);
        isPaused = true;        
        Time.timeScale = 0f;
    }

    public void ResumeGame()
    {
        miniP.SetActive(false);
        isPaused = false;
        Time.timeScale = 1f;
    }

    public void GoToMainMenu()
    {
        Time.timeScale = 1;
        SceneManager.LoadScene("Menu");
        isPaused = false;
    }

    public void QuitGame()
    {
        Application.Quit();
    }

    public void GoToStore()
    {
        SceneManager.LoadScene("Store");
    }

    public void SetFullscreen(bool isFullscreen)
    {
        Screen.fullScreen = isFullscreen;
    }

    public void SetQuality(int qualityIndex)
    {
        QualitySettings.SetQualityLevel(qualityIndex);
    }
}
