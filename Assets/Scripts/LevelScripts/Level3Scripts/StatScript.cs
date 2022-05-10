using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class StatScript : MonoBehaviour
{
    //private GameObject statText;
    public TextMeshProUGUI statText;

    void Start()
    {
        SpeedstingerBaby speedBabe = new SpeedstingerBaby();
        statText.GetComponent<TextMeshProUGUI>().text = "Jump: " + speedBabe.GetJumpForce().ToString() + "\nSpeed: " + speedBabe.GetSpeedForce().ToString() + "\nTurn: " + speedBabe.GetTurnSpeed().ToString();
    }
}
