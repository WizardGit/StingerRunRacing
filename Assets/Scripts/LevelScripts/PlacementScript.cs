/*
 * Author: Kaiser Slocum
 * Last Modified: 9/13/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;
using UnityEngine.SceneManagement;

public class PlacementScript : MonoBehaviour
{
    public int levelNum;
    public GameObject dragonPlayers;
    public GameObject npcRacers;
    private PlayerController player;
    public TextMeshProUGUI raceBoard;
    public TextMeshProUGUI coinsWin;
    private int rankCounter = 1;
    public GameObject checkpoints;
    private List<int> stuff = new List<int>();
    
    private float time = 0.0f;
    private float startTime = 3.0f;
    public TextMeshProUGUI timeText;
    public GameObject pauseMenu;
    public GameObject ledBoard;
    private SaveGame theSave;

    private void Start()
    {
        timeText.text =  "Time: 0:0.0";
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();

        ledBoard.SetActive(false);
        // Get our target
        for (int i = 0; i < theSave.userSave.dragons.Count; i++)
        {
            if (theSave.userSave.dragons[i].GetUse() == "Using")
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

        if (startTime > 0)
        {
            startTime -= Time.deltaTime;
        }
        if (startTime <= 0)
        {
            time += Time.deltaTime;
            if (stuff[0] != 1)
            {
                float minutes = MathF.Truncate(time / 60);
                float seconds = MathF.Round(time - (minutes * 60), 2);
                timeText.text = "Time: " + minutes + ":" + seconds;
            }           
        }

        if ((player.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[0] != 1))
        {   
            float theTheTime = time;
            FinishPlayer(theTheTime);
            raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + player.username + ": " + MathF.Round(theTheTime, 3).ToString();
            SaveGame usersave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();

            int numCoins = (npcRacers.transform.childCount + 3 - rankCounter) * 10;
            usersave.userSave.coins += numCoins;
            coinsWin.text = "You just won " + numCoins + " Coins!";

            
            stuff[0] = 1;
            usersave.userSave.SaveUser();
        }
        else
        {
            for (int i = 0; i < npcRacers.transform.childCount; i++)
            {
                WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();

                if ((racer.checkpointsReached == (checkpoints.transform.childCount + 1)) && (stuff[i + 1] != 1))
                {
                    FinishNPC(time, racer.username);
                    raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + racer.username + ": " + MathF.Round(time, 3).ToString();
                    stuff[i + 1] = 1;
                }

                if ((racer.checkpointsReached > player.checkpointsReached)
                || ((racer.checkpointsReached == player.checkpointsReached) && (racer.disToCheckpoint < player.disToCheckpoint)))
                {
                    placement++;
                }
            }
        }        
        gameObject.GetComponent<TextMeshProUGUI>().text = "Ranking: " + placement.ToString();
    }

    void FinishPlayer(float localTime)
    {
        if ((localTime < theSave.userSave.levelTimes[levelNum - 1]) || (theSave.userSave.levelTimes[levelNum - 1] < 0))
            theSave.userSave.levelTimes[levelNum - 1] = localTime;

        theSave.userSave.SaveUser();
        theSave.ledSave.SaveTime(levelNum, NameTransfer.theName, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = NameTransfer.theName + ": " + MathF.Round(localTime, 3);
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = theSave.ledSave.GetLeaderboard(levelNum);

        ledBoard.SetActive(true);
    }
    void FinishNPC(float localTime, string racerUsername)
    {
        theSave.ledSave.SaveTime(levelNum, racerUsername, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = theSave.ledSave.GetLeaderboard(levelNum);
    }
}
