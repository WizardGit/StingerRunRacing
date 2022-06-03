/*
 * Author: Kaiser Slocum
 * Last Modified: 5/30/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

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
    public AudioSource creakyDoor;

    private int m_CurrentWaypointIndex = 1;
    [HideInInspector] public bool goTime = false;

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
        bool raySuccess = Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 5.0f);
        if (raySuccess == true)
        {
            if ((hit.transform.tag == "Player") && (missionStarted == false))
            {
                animator.Play("Talk");
                haraldSpeaks.Play();
                missionStarted = true;
                yesNoCanvas.SetActive(true);
            }
        }

        if ((navMeshAgent.velocity.x != 0) && (navMeshAgent.isStopped == false))
        {
            animator.Play("Run");
            if (audioFootsteps.isPlaying == false)
                audioFootsteps.Play();
        }
        else
        {
            if ((animator.IsPlaying("PickLock") == false) && (animator.IsPlaying("IdleAction") == false) && (haraldSpeaks.isPlaying == false))
            {
                // If the player is in front of Harald, Harold is in action stance, otherwise he is just idel
                if ((raySuccess == false) || (hit.transform.tag != "Player"))
                    animator.Play("Idle");
                else
                    animator.Play("IdleAction");
            }
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
        }

        if ((navMeshAgent.isStopped == false) && (m_CurrentWaypointIndex != 0))
            Move();
        else if ((navMeshAgent.isStopped == false) && (m_CurrentWaypointIndex == 0))
        {
            gameObject.transform.rotation = Quaternion.RotateTowards(gameObject.transform.rotation, Quaternion.Euler(new Vector3(0, 180, 0)), 100 * Time.deltaTime);
        }
        else if ((m_CurrentWaypointIndex == 2) && (animator.IsPlaying("PickLock") == false))
        {
            navMeshAgent.isStopped = false;
            navMeshAgent.SetDestination(waypoints.transform.GetChild(1).transform.position);
            m_CurrentWaypointIndex = 1;
            goTime = true;
        }
        if (goTime == true)
        {
            if ((creakyDoor.isPlaying == false) && (cageDoor.transform.rotation != Quaternion.Euler(new Vector3(0, 270, 0))))
                creakyDoor.Play();
            cageDoor.transform.rotation = Quaternion.RotateTowards(cageDoor.transform.rotation, Quaternion.Euler(new Vector3(0, 270, 0)), 25 * Time.deltaTime);               
        }
    }

    void Move()
    {
        if (m_CurrentWaypointIndex != 0)
        {
            if ((navMeshAgent.pathPending == false) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
            {
                if (m_CurrentWaypointIndex == 2)
                {
                    navMeshAgent.isStopped = true;
                    animator.Play("PickLock");
                }
                else if (goTime == true)
                {
                    m_CurrentWaypointIndex = (m_CurrentWaypointIndex - 1) % waypoints.transform.childCount;
                    navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
                }
                else
                {
                    m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.transform.childCount;
                    navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
                }
            }
        }        
    }
}
