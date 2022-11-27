/*
 * Author: Kaiser Slocum
 * Last Modified: 11/26/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AlphaMove : MonoBehaviour
{
    public UnityEngine.AI.NavMeshAgent navMeshAgent;
    public GameObject waypoint;
    private Animator animator;
    public AudioSource audioFootsteps;
    public AudioSource audioRoar;
    public GameObject Harald;
    private GameObject target;
    public GameObject models;
    private bool getOut = false;

    void Start()
    {
        animator = GetComponent<Animator>();
        // Get the correct dragon to follow!
        UserSave usersave = new UserSave(NameTransfer.theName);        
        target = models.transform.GetChild(usersave.IndexOfDragonInUse()).gameObject;

        if ((usersave.quests.Count > 0) && (usersave.quests[0] == 0))
        {
            navMeshAgent.Warp(new Vector3(target.transform.position.x+1, target.transform.position.y, target.transform.position.z));            
            navMeshAgent.isStopped = false;
        }
        else
        {
            // Calculate the first place for our dragon to move to
            navMeshAgent.isStopped = true;
            navMeshAgent.SetDestination(waypoint.transform.position);
        }
    }

    void FixedUpdate()
    {
        if ((Harald.GetComponent<HaraldMove>().goTime == true) && (navMeshAgent.isStopped == true))
        {
            // As soon as the cage opens we do the following
            navMeshAgent.isStopped = false;
            audioRoar.Play();
        }
        if ((navMeshAgent.pathPending == false) && (getOut == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
        {
            // As soon as we reach the preliminary waypoint, we set the bool to true
            getOut = true;
        }
        // From now on, we'll just set the waypoint to the player dragon
        if (getOut == true)
            navMeshAgent.SetDestination(target.transform.position + new Vector3(3, 0, 0));

        if (navMeshAgent.velocity.x != 0)
        {
            animator.SetBool("isIdleHappy", false);
            animator.SetBool("isRun", true);
            if ((audioFootsteps.isPlaying == false) && (audioRoar.isPlaying == false))
                audioFootsteps.Play();
        }
        else
        {
            // If we are in the cage, we play the idle sad animation, but if we are out (represented by goTime == true), than we play the happy idle animation
            animator.SetBool("isRun", false);
            if (Harald.GetComponent<HaraldMove>().goTime == false)
                animator.SetBool("isIdleHappy", true);
            else
                animator.SetBool("isIdleHappy", true);
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }
    }
}