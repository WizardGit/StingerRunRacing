/*
 * Author: Kaiser Slocum
 * Last Modified: 5/19/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class WaypointTrip : MonoBehaviour
{
    public NavMeshAgent navMeshAgent;
    public Transform[] waypoints;
    private Animation animator;
    private float pastX = 0.0f;
    private float time = 0.0f;
    private bool start = false;

    int m_CurrentWaypointIndex;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.SetDestination(waypoints[0].position);
        Debug.Log(waypoints[0].position.ToString());
        Debug.Log(navMeshAgent.name + navMeshAgent.remainingDistance.ToString());
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
            if ((time >= 3.0f) && (start == false))
            {
                start = true;
                navMeshAgent.isStopped = false;
            }
        }        
    }

    void Move()
    {
        if ((navMeshAgent.remainingDistance != 0) && (navMeshAgent.remainingDistance < navMeshAgent.stoppingDistance))
        {
            if (m_CurrentWaypointIndex == waypoints.Length-1)
            {
                navMeshAgent.isStopped = true;
            }
            m_CurrentWaypointIndex = (m_CurrentWaypointIndex + 1) % waypoints.Length;
            navMeshAgent.SetDestination(waypoints[m_CurrentWaypointIndex].position);
        }
    }
}
