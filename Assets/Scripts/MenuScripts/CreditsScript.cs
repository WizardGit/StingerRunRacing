/*
 * Authors: Sofi Vinas, Kaiser Slocum
 * Last Modified: 5/31/2022
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
}
