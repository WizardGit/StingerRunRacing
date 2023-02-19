/*
 * Author: Kaiser Slocum
 * Last Modified: 11/26/2022
 * Purpose: Controls player movements
 */

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class PlayerRacingController : MonoBehaviour
{
    // Dictates how many checkpoints there are
    [HideInInspector] public int numCheckpoints; 
    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public int lapsCompleted = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;
    [HideInInspector] public bool isAiming = false;
    [HideInInspector] public int placement = -1;
    private int aimTarget = -1;
    private const float speedBoostMultiplier = 1.5f;
    private int numBoosts = 0;

    // Public Game Objects - MUST be assigned to    
    [HideInInspector] public GameObject checkpoints;
    [HideInInspector] public GameObject ledBoard;
    [HideInInspector] public TextMeshProUGUI distanceText;

    // Private Game objects
    private PlacementScript placScript;
    private CheckpointsScript checkpointScript;
    private PowerUpsScript powerUpsScript;
    private GameObject npcRacers;    
    private PlayerController playerController;
    private SaveGame theSave;

    // Start is called before the first frame update
    private void Start()
    {        
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        powerUpsScript = GameObject.Find("Powerups").GetComponent<PowerUpsScript>();
        npcRacers = GameObject.Find("NPCs");
        placScript = GameObject.Find("PlacementText").GetComponent<PlacementScript>();
        checkpointScript = GameObject.Find("Checkpoints").GetComponent<CheckpointsScript>();
        playerController = gameObject.GetComponent<PlayerController>();
        checkpoints = GameObject.FindGameObjectWithTag("Checkpoints");
        distanceText = GameObject.FindGameObjectWithTag("NextCheckpoint").GetComponent<TextMeshProUGUI>();
        ledBoard = GameObject.FindGameObjectWithTag("Leaderboard");

        numCheckpoints = checkpoints.transform.childCount;
        if (theSave.userSave.racerTag == true)
            transform.GetChild(3).gameObject.SetActive(true);
        CalcNextCheckpoint();

        playerController.isPause = true;
    }
        
    private void FixedUpdate()
    {
        if (((playerController.time - playerController.boostTimer) > 2f) && (playerController.boostTimer > 0))
        {
            playerController.messageText.text = "";
        }

        if ((placScript.startTime <= 0) && (playerController.isPause == false))
        {
            // If our boost time is done, reset our max speed
            if ((numBoosts >= 1) && ((playerController.boostTimer - playerController.time) <= (playerController.boostTimeLength * (numBoosts-1))))
            {
                playerController.playerMaxSpeed /= speedBoostMultiplier;
                numBoosts--;
                if (playerController.playerMaxSpeed < 0)
                {
                    playerController.playerMaxSpeed = 0;
                    Debug.Log("Player Controller: We got curMaxSpeed < 0!");
                }

                playerController.cf.GetComponent<CameraFollow>().isAccel = false;
            }

            // Don't bother calculating next checkpoint, if we aren't moving, there is nothing to calculate!
            if (playerController.playerSpeed > 0)
                CalcNextCheckpoint();
        }

        if ((isAiming == true) && (aimTarget >= 0) && (transform.GetChild(5).gameObject.GetComponent<ParticleSystem>().isPlaying == true))
        {
            // DistVec represents the vector between the player and the next npc racer
            Vector3 distVec = npcRacers.transform.GetChild(aimTarget).gameObject.transform.position + new Vector3(0, 1, 0) - transform.GetChild(5).gameObject.transform.position;
            transform.GetChild(5).gameObject.transform.rotation = Quaternion.LookRotation(distVec);

            var main = transform.GetChild(5).gameObject.GetComponent<ParticleSystem>().main;
            main.simulationSpace = ParticleSystemSimulationSpace.Local;            
        }
        else
        {
            transform.GetChild(5).gameObject.transform.rotation = gameObject.transform.rotation;

            var main = transform.GetChild(5).gameObject.GetComponent<ParticleSystem>().main;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("RingTarget"))
        {
            // Set our reset position to this newest checkpoint
            playerController.resetPos = other.gameObject.transform.position;
            // Notify checkpoint script that we hit it! (Make sure to give it the INDEX of the checkpoint            
            if (checkpointScript.HitCheckpoint(other.gameObject.transform.parent.transform.GetSiblingIndex()) == true)
                checkpointsReached++;
        }
        else if (other.gameObject.CompareTag("FlyingBox"))
        {
            numBoosts++;
            if (playerController.boostTimer > playerController.time)
                playerController.boostTimer += playerController.boostTimeLength;
            else
                playerController.boostTimer = playerController.time + playerController.boostTimeLength;

            other.gameObject.SetActive(false);
            playerController.messageText.text = "<size=200%> Double Speed!";            
            playerController.playerMaxSpeed *= speedBoostMultiplier;
            playerController.OnRoar();
        }
        else if (other.gameObject.CompareTag("Finish"))
        {
            playerController.resetPos = other.gameObject.transform.position;
            //Transform temp = other.gameObject.transform.parent.transform;
            if (checkpointScript.HitCheckpoint(other.gameObject.transform.parent.transform.GetSiblingIndex()) == true)
            {
                checkpointsReached++;
                lapsCompleted++;
                powerUpsScript.ResetCheckpoints();
                if (placScript.numLaps == lapsCompleted)
                {
                    //Debug.Log("finish");
                    playerController.isPause = true;
                    playerController.SetAnimatorBool("isIdleHappy");
                    playerController.messageText.text = "";
                    playerController.speedText.text = "0 mph";
                    playerController.speedBar.fillAmount = 0;
                    distanceText.text = "Next: 0";
                }
            }
        }
        else if (other.gameObject.CompareTag("CatapultArm"))
        {
            transform.position = playerController.resetPos;
            playerController.OnRoar();
        }
    }

    private void OnAim()
    {
        isAiming = !isAiming;
    }

    private void OnChooseTarget()
    {
        int endpointNum = aimTarget;
        if (endpointNum == -1)
            endpointNum = 0;
        if ((aimTarget != -1) && (npcRacers.transform.GetChild(aimTarget).gameObject.transform.GetChild(4).gameObject.GetComponent<TargetScript>().canAim == false))
            aimTarget = -1;

        int g = endpointNum + 1;
        if (g >= npcRacers.transform.childCount)
            g = 0;

        for (int i = g; i < npcRacers.transform.childCount; i++)
        {
            if (i == endpointNum)
                break;

            if (npcRacers.transform.GetChild(i).gameObject.transform.GetChild(4).gameObject.GetComponent<TargetScript>().canAim == true)
            {
                if (aimTarget == -1)
                    aimTarget = i;
                else
                {
                    npcRacers.transform.GetChild(aimTarget).gameObject.transform.GetChild(4).gameObject.GetComponent<TargetScript>().setRed = false;
                    aimTarget = i;
                    npcRacers.transform.GetChild(i).gameObject.transform.GetChild(4).gameObject.GetComponent<TargetScript>().setRed = true;
                }
                break;
            }

            if (i == npcRacers.transform.childCount - 1)
                i = -1;
        }
    }
    private void CalcNextCheckpoint()
    {
        if (playerController.isPause == false)
        {
            Transform cp = checkpoints.transform.GetChild(checkpointsReached - (numCheckpoints * lapsCompleted)).transform;

            if (cp.gameObject.CompareTag("Checkpoint") || cp.gameObject.CompareTag("FinishLine"))
            {
                Vector3 disVec = cp.position - gameObject.transform.position;
                disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
                distanceText.text = "Next: " + MathF.Round(disToCheckpoint, 2).ToString();
            }
            else
            {
                Debug.Log("PlayerController - Checkpoint Fail!");
            }
        }
    }

    public void StartGoing()
    {
        playerController.isPause = false;
    }
}
