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

    void Start()
    {
        SpeedstingerBaby speedBabe = new SpeedstingerBaby();
        statText.GetComponent<TextMeshProUGUI>().text = "Jump: " + speedBabe.GetJumpForce().ToString() + "\nSpeed: " + speedBabe.GetSpeedForce().ToString() + "\nTurn: " + speedBabe.GetTurnSpeed().ToString();
    }

    public void HandleBackButton()
    {
        SceneManager.LoadScene("Menu");
    }
    public void HandleContinueButton()
    {
        Debug.Log("here");
        SceneManager.LoadScene("LevelThree");
    }
}
