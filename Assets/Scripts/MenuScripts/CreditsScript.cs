/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 11/11/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CreditsScript : MonoBehaviour
{
    public void LoadMenu()
    {
        GetComponent<AudioSource>().Play();
        SceneManager.LoadScene("Menu");
    }
    public void LoadParty()
    {
        SceneManager.LoadScene("DanceScene");
    }
}
