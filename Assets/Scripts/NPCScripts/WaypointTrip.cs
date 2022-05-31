/*
 * Author: Kaiser Slocum
 * Last Modified: 5/30/2022
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
    public NavMeshAgent navMeshAgent;
    public GameObject waypoints;
    private Animation animator;
    public AudioSource audioFootsteps;
    private float pastX = 0.0f;
    [HideInInspector] public float time = 0.0f;
    [HideInInspector] public string username;
    private bool start = false;
    public GameObject ledBoard;

    private int m_CurrentWaypointIndex = 0;

    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;
    public GameObject checkpoints;
    public GameObject finishLine;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
        navMeshAgent.isStopped = true;
        username = gameObject.name;
    }

    void FixedUpdate()
    {
        time += Time.deltaTime;
        CalcNextCheckpoint();

        float movementX = navMeshAgent.velocity.x;
        float movementY = navMeshAgent.velocity.y;
        if ((movementX != 0) && (navMeshAgent.isStopped == false))
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
        pastX = movementX;

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
        //Debug.Log(navMeshAgent.remainingDistance.ToString());
        if ((navMeshAgent.pathPending == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
        {
            //Debug.Log(navMeshAgent.name + ": " + m_CurrentWaypointIndex.ToString());
            //Debug.Log(navMeshAgent.remainingDistance.ToString());
            if (m_CurrentWaypointIndex == waypoints.transform.childCount-1)
            {
                // We are done!
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
                ledsave.SaveTime(levelNum, navMeshAgent.name, time);
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
        else if (checkpointsReached > checkpoints.transform.childCount)
        {
            return;
        }
        else
        {
            Vector3 disVec = checkpoints.transform.GetChild(checkpointsReached).transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
        }           

        if ((disToCheckpoint < 12) && (checkpointsReached <= checkpoints.transform.childCount))
        {
            Debug.Log("Checkpoints Reached: " + checkpointsReached);
            checkpointsReached++;
        }
    }    
}
