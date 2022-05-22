/*
 * Author: Kaiser Slocum
 * Last Modified: 5/22/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

public class PlacementScript : MonoBehaviour
{
    public GameObject dragonPlayers;
    public GameObject npcRacers;
    private PlayerController player;

    private void Start()
    {
        UserSave usersave = new UserSave(NameTransfer.theName);
        // Get our target
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
                player = dragonPlayers.transform.GetChild(i).gameObject.GetComponent<PlayerController>();
        }
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        int placement = 1;

        for (int i = 0; i < npcRacers.transform.childCount; i++)
        {
            WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();

            if ((racer.checkpointsReached > player.checkpointsReached) 
            || ((racer.checkpointsReached == player.checkpointsReached) && (racer.disToCheckpoint < player.disToCheckpoint)))
                placement++;
        }
        gameObject.GetComponent<TextMeshProUGUI>().text = "Ranking: " + placement.ToString();
    }
}
