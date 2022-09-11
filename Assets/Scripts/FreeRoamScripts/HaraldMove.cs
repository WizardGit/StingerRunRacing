/*
 * Author: Kaiser Slocum
 * Last Modified: 9/5/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using TMPro;

public class HaraldMove : MonoBehaviour
{
    public UnityEngine.AI.NavMeshAgent navMeshAgent;
    public GameObject waypoints;
    private Animation animator;
    public AudioSource audioFootsteps;
    public AudioSource haraldSpeaks;
    public GameObject cageDoor;
    public GameObject yesNoCanvas;
    private UserSave theUser;
    public AudioSource creakyDoor;
    public GameObject questSword;
    public Material questExclam;
    public Material questQuesti;
    public GameObject questPlane;

    private int m_CurrentWaypointIndex = 1;
    [HideInInspector] public bool goTime = false;

    void Start()
    {
        animator = GetComponent<Animation>();
        navMeshAgent.isStopped = true;
        navMeshAgent.SetDestination(waypoints.transform.GetChild(m_CurrentWaypointIndex).transform.position);
        yesNoCanvas.SetActive(false);
        theUser = new UserSave(NameTransfer.theName);
        if (theUser.quests.Count < 2)
        {
            theUser.quests.Add(2);
            theUser.quests.Add(2);
            theUser.SaveUser();
        }
        else if (theUser.quests[0] == 0)
        {
            goTime = true;         
        }
        if (theUser.quests[1] == 1)
        {
            questSword.SetActive(true);
        }

        CheckQuestPlane();
    }    

    void FixedUpdate()
    {
        if ((navMeshAgent.velocity.x != 0) && (navMeshAgent.isStopped == false))
        {
            animator.Play("Run");
            if (audioFootsteps.isPlaying == false)
                audioFootsteps.Play();
            if (questPlane.activeSelf == true)
                questPlane.SetActive(false);
        }
        else
        {
            if (animator.IsPlaying("PickLock") == false)
                animator.Play("Idle");
            if (audioFootsteps.isPlaying == true)
                audioFootsteps.Pause();
            if (questPlane.activeSelf == false)
                CheckQuestPlane();
        }

        if (theUser.quests[0] != 0)
            CheckQuestOne();
        else if (theUser.quests[1] != 0)
            CheckQuestTwo();
    }        

    public void HandleQuests()
    {
        for (int i = 0; i < theUser.quests.Count; i++)
        {
            if (theUser.quests[i] != 0)
            {                
                // If Quest 1: Harald Rescues Baby Dragon
                if ((i == 0) && (theUser.quests[i] == 2))
                {
                    animator.Play("Talk");
                    haraldSpeaks.Play();
                    yesNoCanvas.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = "Would you like me to rescue your friend?";
                    yesNoCanvas.SetActive(true);

                }
                // If Quest 2: Harald tells you to destroy the sword
                else if (i == 1)
                {
                    if (theUser.quests[i] == 2)
                    {
                        yesNoCanvas.transform.GetChild(0).gameObject.GetComponent<TextMeshProUGUI>().text = 
                            "Astrid has a powerful sword in her possession. \n" +
                            "You need to find it and destroy it before it falls into the wrong hands!"; 
                    }
                    else
                        yesNoCanvas.transform.GetChild(3).gameObject.SetActive(false);
                    yesNoCanvas.SetActive(true);
                }
                return;
            }
        }
    }

    public void HandleYes()
    {
        yesNoCanvas.SetActive(false);
        for (int i = 0; i < theUser.quests.Count; i++)
        {
            if (theUser.quests[i] != 0)
            {
                
                // If Quest 1: Harald Rescues Baby Dragon
                if (i == 0)
                {
                    navMeshAgent.isStopped = false;        
                }
                // If Quest 2: Harald tells you to destroy the sword
                else if (i == 1)
                {                    
                    questSword.SetActive(true);
                }

                if (theUser.quests[i] == 2)
                {
                    theUser.quests[i] = theUser.quests[i] - 1;
                    theUser.SaveUser();
                }
                else
                    yesNoCanvas.transform.GetChild(3).gameObject.SetActive(true);

                CheckQuestPlane();
                return;
            }            
        }
    }

    public void HandleNo()
    {
        yesNoCanvas.SetActive(false);
    }

    private void CheckQuestOne()
    {
        if ((navMeshAgent.isStopped == false) && (m_CurrentWaypointIndex != 0))
            QuestOneMove();
        else if ((navMeshAgent.isStopped == false) && (m_CurrentWaypointIndex == 0))
        {
            gameObject.transform.rotation = Quaternion.RotateTowards(gameObject.transform.rotation, Quaternion.Euler(new Vector3(0, 180, 0)), 100 * Time.deltaTime);
            if (gameObject.transform.rotation == Quaternion.Euler(new Vector3(0, 180, 0)))
            {
                theUser.quests[0] = theUser.quests[0] - 1;
                theUser.SaveUser();
                CheckQuestPlane();
            }
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
    private void QuestOneMove()
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

    private void CheckQuestTwo()
    {
        if ((questSword.activeSelf == false) && (theUser.quests[1] == 1))
        {
            theUser.quests[1] = 0;
            theUser.SaveUser();
            CheckQuestPlane();
        }
    }

    private void CheckQuestPlane()
    {
        for (int i = 0; i < theUser.quests.Count; i++)
        {
            if (theUser.quests[i] != 0)
            {
                Debug.Log(i);
                Debug.Log(theUser.quests[i]);
                if (questPlane.activeSelf == false)
                    questPlane.SetActive(true);

                if ((theUser.quests[i] == 2) && (questPlane.GetComponent<Renderer>().material != questExclam))
                    questPlane.GetComponent<Renderer>().material = questExclam;
                else if ((theUser.quests[i] == 1) && (questPlane.GetComponent<Renderer>().material != questQuesti))
                    questPlane.GetComponent<Renderer>().material = questQuesti;
                return;
            }
        }
        questPlane.SetActive(false);
    }
}
