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
    private void Start()
    {

    }
    private void FixedUpdate()
    {
        
    }
    // Start is called before the first frame update
    public void GoBack()
    {
        Debug.Log("HIT");
        SceneManager.LoadScene("Credits");
    }
}
