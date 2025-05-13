/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 11/11/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;
using UnityEngine.UI;

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
    public GameObject sndButton;


    public GameObject ScreenShakeToggle;
    public GameObject CameraLagToggle;
    public GameObject RacerTagToggle;

    private SaveGame theSave;

    private void Start()
    {
        allAudioSources = FindObjectsOfType(typeof(AudioSource)) as AudioSource[];
        foreach (AudioSource audioS in allAudioSources)
        {
            audioS.Stop();
        }
        backgroundMusic.Play();

        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        if (theSave.userSave.cameraLag == true)
            CameraLagToggle.GetComponent<Toggle>().isOn = true;
        else
            CameraLagToggle.GetComponent<Toggle>().isOn = false;
        if (theSave.userSave.screenShake == true)
            ScreenShakeToggle.GetComponent<Toggle>().isOn = true;
        else
            ScreenShakeToggle.GetComponent<Toggle>().isOn = false;
        if (theSave.userSave.racerTag == true)
            RacerTagToggle.GetComponent<Toggle>().isOn = true;
        else
            RacerTagToggle.GetComponent<Toggle>().isOn = false;
        CheckLevelAvailability();


        Debug.Log("Active Scene: " + SceneManager.GetActiveScene().name);
        foreach (var scene in SceneManager.GetAllScenes())
        {
            Debug.Log("Loaded Scene: " + scene.name + ", IsLoaded: " + scene.isLoaded);
        }
    }

    public void CheckLevelAvailability()
    {
        if (theSave.userSave.numSheep >= 10)
            sndButton.SetActive(true);
        else
            sndButton.SetActive(false);
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
    public void ChangeScreenShake()
    {
        if (ScreenShakeToggle.GetComponent<Toggle>().isOn != theSave.userSave.screenShake)
        {
            theSave.userSave.screenShake = !theSave.userSave.screenShake;
            theSave.userSave.SaveUser();
        }
    }
    public void ChangeCameraLag()
    {
        if (CameraLagToggle.GetComponent<Toggle>().isOn != theSave.userSave.cameraLag)
        {
            theSave.userSave.cameraLag = !theSave.userSave.cameraLag;
            theSave.userSave.SaveUser();
        }
    }
    public void ChangeRacerTag()
    {
        if (RacerTagToggle.GetComponent<Toggle>().isOn != theSave.userSave.racerTag)
        {
            theSave.userSave.racerTag = !theSave.userSave.racerTag;
            theSave.userSave.SaveUser();
        }
    }
}
