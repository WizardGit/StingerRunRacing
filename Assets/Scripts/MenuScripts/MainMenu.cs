/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 5/29/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Video;

public class MainMenu : MonoBehaviour
{
    public AudioSource clickSound;
    public GameObject loadingSystem;
    private float timer = 0.0f;
    private string sceneToLoad = "nothing";
    private bool runTimer = false;

    private void FixedUpdate()
    {
        if (runTimer == true)
            timer += Time.deltaTime;
        if (timer >= 3.0f)
            SceneManager.LoadScene(sceneToLoad);
    }

    public void PlayGame()
    {
        loadingSystem.SetActive(true);
        clickSound.Play();
        runTimer = true;
        sceneToLoad = "LevelOne";
    }

    public void PlayGame2()
    {
        loadingSystem.SetActive(true);
        clickSound.Play();
        runTimer = true;
        sceneToLoad = "LevelTwo";
    }
    
    public void PlayGame3()
    {
        loadingSystem.SetActive(true);
        clickSound.Play();
        runTimer = true;
        sceneToLoad = "LevelThreeCanvas";
    }    

    public void PlayStore()
    {
        SceneManager.LoadScene("Store");
    }

    public void Credits()
    {
        SceneManager.LoadScene("Credits");
    }

    /*
    public void PlayTutorial()
    {
        SceneManager.LoadScene("Tutorial")
    }
    */

    public void PlayFreeRoam()
    {
        SceneManager.LoadScene("FreeRoam");
    }

    public void QuitGame()
    {
        Debug.Log("QUIT!");
        Application.Quit();
    }
}
