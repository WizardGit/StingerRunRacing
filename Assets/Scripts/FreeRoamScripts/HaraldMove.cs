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

public class HaraldMove : MonoBehaviour
{
    public UnityEngine.AI.NavMeshAgent navMeshAgent;
    public GameObject waypoints;
    private Animation animator;
    public AudioSource audioFootsteps;
    public AudioSource haraldSpeaks;
    public GameObject cageDoor;
    public GameObject yesNoCanvas;
    private bool missionStarted = false;

    private int m_CurrentWaypointIndex = 1;
    public bool goTime = false;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.isStopped = true;
        navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
        yesNoCanvas.SetActive(false);

    }

    public void HandleYes()
    {
        yesNoCanvas.SetActive(false);
        navMeshAgent.isStopped = false;
    }

    public void HandleNo()
    {
        yesNoCanvas.SetActive(false);
    }

    void FixedUpdate()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 5.0f))
        {
            if ((hit.transform.tag == "Player") && (missionStarted == false))
            {
                haraldSpeaks.Play();
                missionStarted = true;
                yesNoCanvas.SetActive(true);
            }
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
            if (animator.IsPlaying("PickLock") == false)
                animator.Play("Idle");
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }

        if ((navMeshAgent.isStopped == false) && (m_CurrentWaypointIndex != 0))
        {
            Move();
        }
        else if ((m_CurrentWaypointIndex == 2) && (animator.IsPlaying("PickLock") == false))
        {
            cageDoor.transform.Rotate(new Vector3(0, 90, 0));
            navMeshAgent.isStopped = false;
            navMeshAgent.SetDestination(waypoints.transform.GetChild(0).transform.position);
            m_CurrentWaypointIndex = 0;
            goTime = true;
        }
    }

    void Move()
    {
        if (m_CurrentWaypointIndex != 0)
        {
            Debug.Log(navMeshAgent.remainingDistance.ToString());
            if ((navMeshAgent.pathPending == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
            {
                if (m_CurrentWaypointIndex == 2)
                {
                    navMeshAgent.isStopped = true;
                    animator.Play("PickLock");
                }
                else
                {
                    m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.transform.childCount;
                    Debug.Log(m_CurrentWaypointIndex.ToString());
                    navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
                }
            }
        }        
    }

}
