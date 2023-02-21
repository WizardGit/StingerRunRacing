/*
 * Author: Kaiser Slocum
 * Last Modified:  2/20/2023
 * Purpose: Get placements for every racer
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class PlacementScript : MonoBehaviour
{    
    private GameObject dragonPlayers;
    private GameObject cntDwnImg;
    private GameObject npcRacers;    
    private GameObject ledBoard;       
    private SaveGame theSave;
    private TextMeshProUGUI timeText;
    private PlayerRacingController player;
    private List<int> playerFinished = new();
    private TextMeshProUGUI raceNames;
    private TextMeshProUGUI coinsWin;
    private int rankCounter = 1;
    private float time = 0.0f;
    private FireworkTrigger finishline;
    
    public AudioSource num;
    public AudioSource go;
    public Standings stands;
    public float startTime = 5.0f;
    public int numLaps = 1;
    public int levelNum;

    private void Start()
    {        
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        timeText = GameObject.FindGameObjectWithTag("Time").GetComponent<TextMeshProUGUI>();
        raceNames = GameObject.FindGameObjectWithTag("RaceNames").GetComponent<TextMeshProUGUI>();
        coinsWin = GameObject.FindGameObjectWithTag("CoinsWin").GetComponent<TextMeshProUGUI>();
        npcRacers = GameObject.FindGameObjectWithTag("NPCs");
        dragonPlayers = GameObject.FindGameObjectWithTag("DragonPlayers");
        ledBoard = GameObject.FindGameObjectWithTag("Leaderboard");
        cntDwnImg = GameObject.FindGameObjectWithTag("CntDwnImgs");
        finishline = GameObject.FindWithTag("FinishLine").GetComponent<FireworkTrigger>();
        
        GameObject.FindWithTag("LevelName").GetComponent<TextMeshProUGUI>().text = SceneManager.GetActiveScene().name;

        timeText.text = "Time: 0:0.0";
        raceNames.text = "";

        ledBoard.SetActive(false);
        // Get our target
        player = dragonPlayers.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject.GetComponent<PlayerRacingController>();

        // We're doing <= because we need to add one for the player
        for (int i = 0; i <= npcRacers.transform.childCount; i++)
        {
            playerFinished.Add(0);
        }
        
        stands = new Standings(npcRacers, dragonPlayers.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject);
    }
        
    void FixedUpdate()
    {   
        if (startTime > 0)
        {
            startTime -= Time.deltaTime;
            OpeningSequence();
        }
        else //(startTime <= 0)
        {
            time += Time.deltaTime;
            if (playerFinished[^1] != 1)
            {
                float minutes = MathF.Truncate(time / 60);
                float seconds = MathF.Round(time - (minutes * 60), 2);
                timeText.text = "Time: " + minutes + ":" + seconds;
            }
            // If it's been three seconds, stop showing "GO"
            if (time > 1)
                cntDwnImg.transform.GetChild(3).transform.gameObject.SetActive(false);
        }
        if ((player.lapsCompleted == numLaps - 1) && ((player.checkpointsReached - (player.numCheckpoints * player.lapsCompleted)) == player.numCheckpoints - 1))
            finishline.StartFireworks();

        if ((player.lapsCompleted == numLaps) && (playerFinished[^1] != 1))
        {
            playerFinished[^1] = 1;
            int numCoins = (npcRacers.transform.childCount + 3 - rankCounter) * 10;
            float theTheTime = time;
            FinishPlayer(theTheTime, numCoins);  

            PlayerController playerC = dragonPlayers.transform.GetChild(theSave.userSave.IndexOfDragonInUse()).gameObject.GetComponent<PlayerController>();
            raceNames.text += (rankCounter++).ToString() + ". " + playerC.username + ": " + MathF.Round(theTheTime, 3).ToString() + "\n";
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
                    raceNames.text += (rankCounter++).ToString() + ". " + racer.npcName + ": " + MathF.Round(time, 3).ToString() + "\n";
                    playerFinished[i] = 1;
                    racer.doStop = true;
                }
            }
        }        
        
        stands.SortStandings();
        stands.UpdatePTags();
        gameObject.GetComponent<TextMeshProUGUI>().text = "Ranking: " + (player.placement + 1).ToString();
    }

    private void FinishPlayer(float localTime, int numCoins)
    {
        theSave.userSave.SaveTimeToLevel(localTime, levelNum);
        theSave.userSave.coins += numCoins;

        theSave.userSave.SaveUser();
        theSave.ledSave.SaveTime(levelNum, NameTransfer.theName, MathF.Round(localTime, 3));
        ledBoard.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = NameTransfer.theName + ": " + MathF.Round(localTime, 3);
        ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = theSave.ledSave.GetLeaderboard(levelNum);

        ledBoard.SetActive(true);
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

                    player.StartGoing();

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

public class Standings
{
    List<GameObject> standings;
    public Standings(GameObject npcRacers, GameObject player)
    {
        standings = new List<GameObject> { player };

        for (int i = 0; i < npcRacers.transform.childCount; i++)
        {
            standings.Add(npcRacers.transform.GetChild(i).gameObject);
        }
    }

    public void SortStandings()
    {
        for (int i = 1; i < standings.Count; i++)
        {
            int c;
            float d;
            int ac;
            float ad;

            if (standings[i].CompareTag("Player") == true)
            {
                PlayerRacingController racer = standings[i].GetComponent<PlayerRacingController>();
                c = racer.checkpointsReached;
                d = racer.disToCheckpoint;
            }
            else
            {
                WaypointTrip racer = standings[i].GetComponent<WaypointTrip>();
                c = racer.checkpointsReached;
                d = racer.disToCheckpoint;
            }

            int ci = i;
            do
            {
                ci--;
                if (ci < 0)
                {
                    break;
                }

                if (standings[ci].CompareTag("Player") == true)
                {
                    PlayerRacingController aracer = standings[ci].GetComponent<PlayerRacingController>();
                    ac = aracer.checkpointsReached;
                    ad = aracer.disToCheckpoint;
                }
                else
                {
                    WaypointTrip aracer = standings[ci].GetComponent<WaypointTrip>();
                    ac = aracer.checkpointsReached;
                    ad = aracer.disToCheckpoint;

                }

            } while (((ac < c) || ((ac == c) && (ad > d))));
            ci++;
            if ((ci) != i)
            {
                GameObject temp = standings[i];
                standings.Remove(temp);
                standings.Insert(ci, temp);
            }
        }        
    }

    public void UpdatePTags()
    {
        for (int i = 0; i < standings.Count; i++)
        {
            
            GameObject ptag = standings[i].transform.GetChild(3).gameObject;
            Material ptagcol = ptag.transform.GetChild(1).gameObject.GetComponent<MeshRenderer>().material;  

            if (standings[i].CompareTag("Player") == true)
            {
                standings[i].GetComponent<PlayerRacingController>().placement = i;
            }
            else
            {
                standings[i].GetComponent<WaypointTrip>().placement = i;
            }

            i++;
            ptag.transform.GetChild(0).transform.GetComponent<TextMesh>().text = i.ToString();

            if (i == 1)
                ptagcol.color = Color.green;
            else if (i < 4)
                ptagcol.color = Color.yellow;
            else
                ptagcol.color = Color.red;
            i--;
        }
    }
}
