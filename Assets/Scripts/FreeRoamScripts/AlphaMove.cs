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

public class AlphaMove : MonoBehaviour
{
    public UnityEngine.AI.NavMeshAgent navMeshAgent;
    public GameObject waypoints;
    private Animation animator;
    public AudioSource audioFootsteps;
    public AudioSource audioFanfare;
    public GameObject Harald;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.isStopped = true;
        navMeshAgent.SetDestination(waypoints.transform.GetChild(0).transform.position);
    }

    void FixedUpdate()
    {
        if (Harald.GetComponent<HaraldMove>().goTime == true)
        {
            navMeshAgent.isStopped = false;
        }        

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
            if (Harald.GetComponent<HaraldMove>().goTime == false)
            {
                animator.Play("IdleSad");
            }
            else
            {
                animator.Play("IdleHappy");
            }
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }

        if ((navMeshAgent.pathPending == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
        {
            navMeshAgent.isStopped = true;
            audioFanfare.Play();
        }
    }
}