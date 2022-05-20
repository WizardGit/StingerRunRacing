/*
 * Author: Kaiser Slocum
 * Last Modified: 5/19/2022
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
    public Transform[] waypoints;
    private Animation animator;
    private float pastX = 0.0f;
    private float time = 0.0f;
    private bool start = false;
    public GameObject ledBoard;

    private int m_CurrentWaypointIndex = 0;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.SetDestination(waypoints[m_CurrentWaypointIndex].position);
        //Debug.Log(waypoints[0].position.ToString());
        //Debug.Log(navMeshAgent.name + navMeshAgent.remainingDistance.ToString());
        navMeshAgent.isStopped = true;
    }

    void FixedUpdate()
    {
        time += Time.deltaTime;

        //Debug.Log(navMeshAgent.name + navMeshAgent.velocity.ToString());
        //Debug.Log(navMeshAgent.name + navMeshAgent.remainingDistance.ToString());

        float movementX = navMeshAgent.velocity.x;
        float movementY = navMeshAgent.velocity.y;
        if ((movementX != 0) && (navMeshAgent.isStopped == false))
            animator.Play("Run");
        else
            animator.Play("IdleHappy");
        pastX = movementX;

        if (navMeshAgent.isStopped == false)
        {
            Move();            
        }
        else if (navMeshAgent.isStopped == true)
        {
            Debug.Log(navMeshAgent.name + ": " + navMeshAgent.isStopped.ToString());
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
            if (m_CurrentWaypointIndex == waypoints.Length-1)
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
                ledBoard.transform.GetChild(1).gameObject.GetComponent<TextMeshProUGUI>().text = ledsave.getLeaderboard(levelNum);

                navMeshAgent.isStopped = true;
            }
            m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.Length;
            navMeshAgent.SetDestination(waypoints[m_CurrentWaypointIndex].position);
        }
    }
}
