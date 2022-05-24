/*
 * Authors: Sofi Vinas
 * Last Modified: 5/8/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class MainMenu : MonoBehaviour
{
    public void PlayGame()
    {
        SceneManager.LoadScene("LevelOne");
    }

    public void PlayGame2()
    {
        SceneManager.LoadScene("LevelTwo");
    }
    
    public void PlayGame3()
    {
        SceneManager.LoadScene("LevelThreeCanvas");
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
