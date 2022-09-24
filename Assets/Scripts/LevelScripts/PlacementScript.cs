/*
 * Author: Kaiser Slocum
 * Last Modified: 9/23/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

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
    private List<int> playerFinished = new List<int>();
    
    private float time = 0.0f;
    public float startTime = 5.0f;
    public TextMeshProUGUI timeText;
    public GameObject pauseMenu;
    public GameObject ledBoard;
    private SaveGame theSave;
    public GameObject cntDwnImg;
    public AudioSource num;
    public AudioSource go;
    public int numLaps = 1;

    private void Start()
    {
        timeText.text =  "Time: 0:0.0";
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();

        ledBoard.SetActive(false);
        // Get our target
        player = dragonPlayers.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject.GetComponent<PlayerController>();

        // We're doing <= because we need to add one for the player
        for (int i = 0; i <= npcRacers.transform.childCount; i++)
        {
            playerFinished.Add(0);
        }
        raceBoard.text = "";
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        // Every frame we update the placement value
        int placement = 1;        

        if (startTime > 0)
        {
            startTime -= Time.deltaTime;
            OpeningSequence();
        }
        else //(startTime <= 0)
        {
            time += Time.deltaTime;
            if (playerFinished[0] != 1)
            {
                float minutes = MathF.Truncate(time / 60);
                float seconds = MathF.Round(time - (minutes * 60), 2);
                timeText.text = "Time: " + minutes + ":" + seconds;
            }
            // If it's been three seconds, stop showing "GO"
            if (time > 3)
                cntDwnImg.transform.GetChild(3).transform.gameObject.SetActive(false);
        }

        if ((player.lapsCompleted == numLaps) && (playerFinished[playerFinished.Count-1] != 1))
        {
            playerFinished[playerFinished.Count - 1] = 1;
            int numCoins = (npcRacers.transform.childCount + 3 - rankCounter) * 10;
            float theTheTime = time;
            FinishPlayer(theTheTime);    
            
            SaveGame usersave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
            usersave.userSave.coins += numCoins;
            usersave.userSave.SaveUser();

            raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + player.username + ": " + MathF.Round(theTheTime, 3).ToString();
            coinsWin.text = "You just won " + numCoins + " Coins!";
        }
        else
        {
            for (int i = 0; i < npcRacers.transform.childCount; i++)
            {
                WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();

                if ((racer.lapsCompleted == numLaps) && (playerFinished[i] != 1))
                {
                    FinishNPC(time, racer.npcName);
                    raceBoard.text += "\n" + (rankCounter++).ToString() + ". " + racer.npcName + ": " + MathF.Round(time, 3).ToString();
                    playerFinished[i] = 1;
                    racer.doStop = true;
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

    private void FinishPlayer(float localTime)
    {
        theSave.userSave.SaveTimeToLevel(localTime, levelNum);

        theSave.userSave.SaveUser();
        theSave.ledSave.SaveTime(levelNum, NameTransfer.theName, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = NameTransfer.theName + ": " + MathF.Round(localTime, 3);
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = theSave.ledSave.GetLeaderboard(levelNum);

        ledBoard.SetActive(true);
        GameObject.Find("FinishLine").GetComponent<FireworkTrigger>().StartFireworks();

    }
    private void FinishNPC(float localTime, string racerUsername)
    {
        theSave.ledSave.SaveTime(levelNum, racerUsername, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = theSave.ledSave.GetLeaderboard(levelNum);
    }

    private void OpeningSequence()
    {
        if (startTime < 3)
        {
            if (startTime > 2)
            {
                if (cntDwnImg.transform.GetChild(0).transform.gameObject.activeSelf == false)
                {
                    cntDwnImg.transform.GetChild(0).transform.gameObject.SetActive(true);
                    num.Play();
                }
            }
            else if (startTime > 1)
            {
                if (cntDwnImg.transform.GetChild(1).transform.gameObject.activeSelf == false)
                {
                    cntDwnImg.transform.GetChild(0).transform.gameObject.SetActive(false);
                    cntDwnImg.transform.GetChild(1).transform.gameObject.SetActive(true);
                    num.Play();
                }
            }
            else if (startTime > 0)
            {
                if (cntDwnImg.transform.GetChild(2).transform.gameObject.activeSelf == false)
                {
                    cntDwnImg.transform.GetChild(1).transform.gameObject.SetActive(false);
                    cntDwnImg.transform.GetChild(2).transform.gameObject.SetActive(true);
                    num.Play();
                }
            }
            else if (startTime <= 0)
            {
                if (cntDwnImg.transform.GetChild(3).transform.gameObject.activeSelf == false)
                {
                    cntDwnImg.transform.GetChild(2).transform.gameObject.SetActive(false);
                    cntDwnImg.transform.GetChild(3).transform.gameObject.SetActive(true);
                    go.Play();

                    for (int i = 0; i < npcRacers.transform.childCount; i++)
                    {
                        WaypointTrip racer = npcRacers.transform.GetChild(i).gameObject.GetComponent<WaypointTrip>();
                        racer.doStop = false;
                    }
                }
            }
        }
    }
}
