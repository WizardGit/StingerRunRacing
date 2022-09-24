/*
 * Author: Kaiser Slocum
 * Last Modified: 9/23/2022
 * Script for NPC's
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class WaypointTrip : MonoBehaviour
{
    // Game Objects needed from inspector
    public NavMeshAgent navMeshAgent;
    public GameObject waypoints;    
    public AudioSource audioFootsteps;
    public GameObject checkpoints;

    // Variables needed just for the script
    private Animation animator;
    [HideInInspector] public bool doStop = true;
    private int curWaypointIndex = 0;
    private NavMeshPath path;

    // Public game objects that inspector should ignore
    [HideInInspector] public int lapsCompleted = 0;
    [HideInInspector] public int checkpointsReached = 0;
    [HideInInspector] public float disToCheckpoint = 0.0f;
    private PlacementScript placScript;
    private int numCheckpoints;
    public string npcName;

    void Start()
    {
        path = new NavMeshPath();
        animator = GetComponent<Animation>();
        navMeshAgent.SetDestination(waypoints.transform.GetChild(curWaypointIndex).transform.position);
        navMeshAgent.isStopped = true;
        npcName = gameObject.name;

        placScript = GameObject.Find("Placement").GetComponent<PlacementScript>();
        numCheckpoints = checkpoints.transform.childCount;
    }

    void FixedUpdate()
    {
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

        if (doStop == false)
        {
            if (navMeshAgent.isStopped == true)
                navMeshAgent.isStopped = false;
            Move();            
        }
        else if ((doStop == true) && (navMeshAgent.isStopped == false))
            navMeshAgent.isStopped = true;
    }

    void Move()
    {
        if (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance)
        {            
            curWaypointIndex = (curWaypointIndex + 1) % waypoints.transform.childCount;
            navMeshAgent.SetPath(path);
        }

        // Calculate the path well ahead of time!
        if (navMeshAgent.remainingDistance < 20)
        {
            navMeshAgent.CalculatePath(waypoints.transform.GetChild((curWaypointIndex + 1) % waypoints.transform.childCount).transform.position, path);            
        }
    }

    private void CalcNextCheckpoint()
    {        
        Transform cp = checkpoints.transform.GetChild(checkpointsReached - (numCheckpoints * lapsCompleted)).transform;
        Vector3 disVec = cp.position - gameObject.transform.position;
        disToCheckpoint = MathF.Abs(disVec.x) + MathF.Abs(disVec.z);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("RingTarget") && (other.gameObject.transform.parent.transform.GetSiblingIndex() == (checkpointsReached - (numCheckpoints * lapsCompleted))))
        {            
            checkpointsReached++;
        }        
        else if (other.gameObject.CompareTag("Finish") && (other.gameObject.transform.parent.transform.GetSiblingIndex() == (checkpointsReached - (numCheckpoints * lapsCompleted))))
        {
            checkpointsReached++;
            if (checkpointsReached == (numCheckpoints * (lapsCompleted + 1)))
            {
                lapsCompleted++;
                if (lapsCompleted == placScript.numLaps)
                    navMeshAgent.isStopped = true;
            }
        }
    }
}
