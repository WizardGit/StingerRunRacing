/*
 * Author: Kaiser Slocum
 * Last Modified: 5/29/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;

public class StatScript : MonoBehaviour
{
    //private GameObject statText;
    public TextMeshProUGUI statText;
    public AudioSource clickSound;

    void Start()
    {
        SpeedstingerTitan speedBabe = new SpeedstingerTitan();
        statText.GetComponent<TextMeshProUGUI>().text = "Jump: " + speedBabe.GetJumpForce().ToString() + "\nSpeed: " + speedBabe.GetSpeedForce().ToString() + "\nTurn: " + speedBabe.GetTurnSpeed().ToString();
    }

    public void HandleBackButton()
    {
        SceneManager.LoadScene("Menu");
        clickSound.Play();
    }
    public void HandleContinueButton()
    {
        Debug.Log("here");
        SceneManager.LoadScene("LevelThree");
        clickSound.Play();
    }
}
