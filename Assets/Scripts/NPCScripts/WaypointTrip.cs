/*
 * Author: Kaiser Slocum
 * Last Modified: 5/31/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.AI;
using UnityEngine.InputSystem;
using TMPro;
using UnityEngine.SceneManagement;

public class WaypointTrip : MonoBehaviour
{
    // Game Objects needed from inspector
    public NavMeshAgent navMeshAgent;
    public GameObject waypoints;    
    public AudioSource audioFootsteps;
    public GameObject checkpoints;
    public GameObject finishLine;
    public GameObject ledBoard;

    // Variables needed just for the script
    private Animation animator;
    private bool start = false;
    private int m_CurrentWaypointIndex = 0;

    // Public game objects that inspector should ignore
    [HideInInspector] public float time = 0.0f;
    [HideInInspector] public string username;
    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
        navMeshAgent.isStopped = true;
        username = gameObject.name;
    }

    void FixedUpdate()
    {
        if (m_CurrentWaypointIndex < waypoints.transform.childCount - 1)
        {
            time += Time.deltaTime;
        }
        CalcNextCheckpoint();

        if ((navMeshAgent.velocity.x != 0) && (navMeshAgent.isStopped == false))
        {
            animator.Play("Run");
            if (audioFootsteps.isPlaying == false)
                audioFootsteps.Play();
        }
        else
        {
            animator.Play("IdleHappy");
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }

        if (navMeshAgent.isStopped == false)
        {
            Move();            
        }
        else if (navMeshAgent.isStopped == true)
        {
            if ((time >= 3.0f) && (start == false))
            {
                start = true;
                navMeshAgent.isStopped = false;
            }
        }        
    }

    void Move()
    {
        if ((navMeshAgent.pathPending == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
        {
            if (m_CurrentWaypointIndex == waypoints.transform.childCount-1)
            {
                UserSave usersave = new UserSave(navMeshAgent.name);
                LeaderboardSave ledsave = new LeaderboardSave();

                string sName = SceneManager.GetActiveScene().name;
                int levelNum = 0;
                if (sName == "LevelOne")
                {
                    levelNum = 1;
                    if ((time < usersave.levelOneTime) || (usersave.levelOneTime < 0))
                        usersave.levelOneTime = time;
                }
                else if (sName == "LevelTwo")
                {
                    levelNum = 2;
                    if ((time < usersave.levelTwoTime) || (usersave.levelTwoTime < 0))
                        usersave.levelTwoTime = time;
                }
                else if (sName == "LevelThree")
                {
                    levelNum = 3;
                    if ((time < usersave.levelThreeTime) || (usersave.levelThreeTime < 0))
                        usersave.levelThreeTime = time;
                }
                else
                {
                    Debug.Log("Scene name unrecognized in player controller!");
                }

                usersave.SaveUser();
                ledsave.SaveTime(levelNum, navMeshAgent.name, MathF.Round(time,3));
                ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = ledsave.GetLeaderboard(levelNum);

                navMeshAgent.isStopped = true;
            }
            m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.transform.childCount;
            navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
        }
    }

    private void CalcNextCheckpoint()
    {

        if (checkpointsReached == checkpoints.transform.childCount)
        {
            Vector3 disVec = finishLine.transform.GetChild(3).gameObject.transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
        }
        else if (checkpointsReached < checkpoints.transform.childCount)
        {
            Vector3 disVec = checkpoints.transform.GetChild(checkpointsReached).transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
        }           

        if ((checkpointsReached <= checkpoints.transform.childCount) && (disToCheckpoint < 12))
            checkpointsReached++;
    }    
}
