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
    public TextMeshProUGUI raceBoard;
    public TextMeshProUGUI coinsWin;
    private int rankCounter = 1;
    public GameObject checkpoints;
    private List<int> stuff = new List<int>();

    private void Start()
    {
        UserSave usersave = new UserSave(NameTransfer.theName);
        // Get our target
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
                player = dragonPlayers.transform.GetChild(i).gameObject.GetComponent<PlayerController>();
        }
        for (int i = 0; i < npcRacers.transform.childCount; i++)
        {
            stuff.Add(0);
        }
        stuff.Add(0);
        raceBoard.text = "";
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        int placement = 1;

        if ((player.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[0] != 1))
        {
            UserSave usersave = new UserSave(NameTransfer.theName);

            if (rankCounter == 1)
            {
                usersave.coins += 30;
                coinsWin.text = "You just won 30 Coins!";
            }
            else if (rankCounter == 2)
            {
                usersave.coins += 20;
                coinsWin.text = "You just won 20 Coins!";
            }
            else
            {
                usersave.coins += 10;
                coinsWin.text = "You just won 10 Coins!";
            }

            raceBoard.text += "\n" + (rankCounter++).ToString() + " " + player.username + ": " + player.time.ToString();
            stuff[0] = 1;
        }

        for (int i = 0; i < npcRacers.transform.childCount; i++)
        {
            WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();

            if ((racer.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[i+1] != 1))
            {
                raceBoard.text += "\n" + (rankCounter++).ToString() + ": " + racer.username + " " + racer.time.ToString();
                stuff[i+1] = 1;
            }

            if ((racer.checkpointsReached > player.checkpointsReached) 
            || ((racer.checkpointsReached == player.checkpointsReached) && (racer.disToCheckpoint < player.disToCheckpoint)))
            {
                placement++;
            }
        }
        gameObject.GetComponent<TextMeshProUGUI>().text = "Ranking: " + placement.ToString();
    }
}
