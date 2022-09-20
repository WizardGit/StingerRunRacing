/*
 * Author: Kaiser Slocum
 * Last Modified: 9/19/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
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
    [HideInInspector] public bool start = false;
    private int m_CurrentWaypointIndex = 0;
    private NavMeshPath path;

    // Public game objects that inspector should ignore
    private float time = 0.0f;
    [HideInInspector] public string username;
    public int numLaps = 1;
    public int onLap = 1;
    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;

    void Start()
    {
        path = new NavMeshPath();
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
            if (start == true)
                navMeshAgent.isStopped = false;
        }        
    }

    void Move()
    {
        if (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance)
        {
            if (m_CurrentWaypointIndex == waypoints.transform.childCount-1)
            {
                onLap++;
                if (onLap > numLaps)
                    navMeshAgent.isStopped = true;
            }
            m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.transform.childCount;
            navMeshAgent.SetPath(path);
        }

        // Calculate the path well ahead of time!
        if (navMeshAgent.remainingDistance < 20)
        {
            navMeshAgent.CalculatePath(waypoints.transform.GetChild((m_CurrentWaypointIndex + 1) % waypoints.transform.childCount).transform.position, path);            
        }
    }

    private void CalcNextCheckpoint()
    {
        if ((checkpointsReached / onLap) == checkpoints.transform.childCount)
        {
            Vector3 disVec = finishLine.transform.GetChild(3).gameObject.transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
        }
        else if (checkpointsReached < (checkpoints.transform.childCount * numLaps))
        {
            Vector3 disVec = checkpoints.transform.GetChild(checkpointsReached).transform.position - gameObject.transform.position;
            disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.y) + MathF.Abs(disVec.z);
        }           

        if ((checkpointsReached <= (checkpoints.transform.childCount * numLaps)) && (disToCheckpoint < 12))
            checkpointsReached++;
    }    
}
