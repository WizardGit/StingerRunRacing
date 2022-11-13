/*
 * Authors: Kaiser Slocum
 * Last Modified: 11/11/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PartyScript : MonoBehaviour
{
    // Start is called before the first frame update
    public void GoBack()
    {
        SceneManager.LoadScene("Credits");
    }
}
