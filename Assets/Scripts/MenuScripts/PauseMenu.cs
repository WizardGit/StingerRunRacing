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

    // button clicks play sound from here
    public void ResumeGame()
    {
        PlayButtonClick();
        miniP.SetActive(false);
        isPaused = false;
        Time.timeScale = 1f;
    }

    public void GoToMainMenu()
    {
        PlayButtonClick();
        Time.timeScale = 1;
        SceneManager.LoadScene("Menu");
        isPaused = false;
    }

    public void QuitGame()
    {
        PlayButtonClick();
        Application.Quit();
    }

    public void GoToStore()
    {
        PlayButtonClick();
        SceneManager.LoadScene("Store");
    }

    public void SetFullscreen(bool isFullscreen)
    {
        PlayButtonClick();
        Screen.fullScreen = isFullscreen;
    }

    public void SetQuality(int qualityIndex)
    {
        PlayButtonClick();
        QualitySettings.SetQualityLevel(qualityIndex);
    }

    // Helper to play the button click sound
    private void PlayButtonClick()
    {
        var uiPlayer = FindObjectOfType<UIAudioPlayer>();
        if (uiPlayer != null)
        {
            uiPlayer.PlayClick();
            return;
        }

        Debug.LogWarning("No UIAudioPlayer found to play pause menu click. Add a UIAudioPlayer to the scene or assign sounds on the PauseMenu.", this);
    }

}


