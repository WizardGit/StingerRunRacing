/*
 * Author: Kaiser Slocum
 * Last Modified: 5/30/2022
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
    private Animation animator;
    public AudioSource audioFootsteps;
    public AudioSource audioRoar;
    public GameObject Harald;
    private GameObject target;
    public GameObject models;
    private bool getOut = false;

    void Start()
    {
        animator = GetComponent<Animation>();
        // Get the correct dragon to follow!
        UserSave usersave = new UserSave(NameTransfer.theName);
        for (int i = 0; i < usersave.dragons.Count; i++)
        {
            if (usersave.dragons[i].GetUse() == "Using")
                target = models.transform.GetChild(i).gameObject;
        }
        // Calculate the first place for our dragon to move to
        navMeshAgent.isStopped = true;
        navMeshAgent.SetDestination(waypoint.transform.position);
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
            animator.Play("Run");
            if ((audioFootsteps.isPlaying == false) && (audioRoar.isPlaying == false))
                audioFootsteps.Play();
        }
        else
        {
            // If we are in the cage, we play the idle sad animation, but if we are out (represented by goTime == true), than we play the happy idle animation
            if (Harald.GetComponent<HaraldMove>().goTime == false)
                animator.Play("IdleSad");
            else
                animator.Play("IdleHappy");
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }
    }
}