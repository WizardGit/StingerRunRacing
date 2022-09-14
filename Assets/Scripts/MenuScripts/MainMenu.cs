/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 9/13/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class MainMenu : MonoBehaviour
{
    public AudioSource clickSound;
    public GameObject loadingSystem;
    private float timer = 0.0f;
    private string sceneToLoad = "nothing";
    private bool runTimer = false;
    public Texture2D cursorArrow;

    private AudioSource[] allAudioSources;
    public AudioSource backgroundMusic;

    private void Start()
    {
        allAudioSources = FindObjectsOfType(typeof(AudioSource)) as AudioSource[];
        foreach (AudioSource audioS in allAudioSources)
        {
            audioS.Stop();
        }
        backgroundMusic.Play();
        Cursor.SetCursor(cursorArrow, Vector2.zero, CursorMode.ForceSoftware);
    }

    private void FixedUpdate()
    {
        if (runTimer == true)
            timer += Time.deltaTime;
        if (timer >= 3.0f)
            SceneManager.LoadScene(sceneToLoad);
    }

    public void PlayGame(string theScene)
    {
        loadingSystem.SetActive(true);
        clickSound.Play();
        runTimer = true;
        sceneToLoad = theScene;
    }

    public void PlayStore()
    {
        SceneManager.LoadScene("Store");
    }

    public void Credits()
    {
        SceneManager.LoadScene("Credits");
    }

    public void PlayFreeRoam()
    {
        clickSound.Play();
        SceneManager.LoadScene("FreeRoam");
    }

    public void QuitGame()
    {
        Debug.Log("QUIT!");
        Application.Quit();
    }
}
