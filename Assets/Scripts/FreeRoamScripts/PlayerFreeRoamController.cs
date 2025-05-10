/*
 * Author: Kaiser Slocum
 * Last Modified: 5/9/2025
 * Purpose: Controls player movement in free roam environments
 */

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class PlayerFreeRoamController : MonoBehaviour
{
    private float gemTimer = 0.0f;
    private PlayerController playerController;
    [HideInInspector] public Camera mainCamera;

    private void Start()
    {
        // Never have players tags in free roam even if player tags are turned on!
        transform.GetChild(3).gameObject.SetActive(false);
        playerController = gameObject.GetComponent<PlayerController>();
        mainCamera = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
    }

    private void FixedUpdate()
    { 
        if ((playerController.time - gemTimer) > 3)
        {
            playerController.messageText.text = "";
        }
    }
    
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("GemPickup"))
        {
            other.gameObject.SetActive(false);
            other.gameObject.transform.parent.gameObject.GetComponent<GemScript>().UpdateGemCollected();
            playerController.messageText.text = "You just earned 10 gems!";
            gemTimer = playerController.time;
        }
        else if (other.gameObject.CompareTag("SwordPickup"))
        {
            other.gameObject.SetActive(false);
            playerController.OnRoar();
            playerController.messageText.text = "You just destroyed the sword! \n Great job.";
            gemTimer = playerController.time;
        }
    }

    private void OnClick()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        // If the theSave clicks on Harald, check for the quests
        if ((Physics.Raycast(ray, out hit) == true) && (hit.transform.CompareTag("Harald")))
            hit.transform.gameObject.GetComponent<HaraldMove>().HandleQuests();
    }
}