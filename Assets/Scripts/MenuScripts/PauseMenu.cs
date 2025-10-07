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
    [Header("Button Click Sound")]
    [Tooltip("AudioSource used to play button click sounds")] 
    public AudioSource clickSound;
    [Tooltip("The sound to play for every button click")] 
    public AudioClip buttonClickClip;

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
        if (clickSound != null && buttonClickClip != null)
        {
            clickSound.PlayOneShot(buttonClickClip);
        }
    }

}


