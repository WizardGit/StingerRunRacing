/*
 * Author: Kaiser Slocum
 * Last Modified: 9/23/2022
 * The Arrow pointing angle code is something I am VERY proud of.
 * Took forever to do!
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckpointsScript : MonoBehaviour
{    
    private Checkpoints checkpointsList;     
    private AudioSource audioBleep;

    // Start is called before the first frame update
    void Start()
    {
        audioBleep = gameObject.GetComponent<AudioSource>();
        checkpointsList = new Checkpoints(gameObject);
        checkpointsList.ResetCheckpoints();
    }

    // Our I should be the index of the checkpoint
    public bool HitCheckpoint(int i)
    {
        if ((i >= checkpointsList.GetCount()) || (i < 0))
        {
            Debug.Log("CheckpointScript: HitCheckpoint: Index is larger than the number of checkpoints or smaller than 0!");
            return false;
        }
        else if (checkpointsList[i].GetColor() == "green")
        {
            audioBleep.Play();
            checkpointsList[i].Deactivate();
            if (i == (checkpointsList.GetCount()-1))
                checkpointsList.ResetCheckpoints();
            else if (i < checkpointsList.GetCount())
                checkpointsList[i + 1].SetGreen();
            return true;
        }
        else
            return false;        
    }
}
public class Checkpoint
{
    private GameObject ringTarget;
    private GameObject checkpointBlock;
    private string color;
    public Checkpoint(GameObject r, GameObject c)
    {
        ringTarget = r;
        checkpointBlock = c;
        color = "green";
    }
    
    public GameObject GetRingT() => ringTarget;
    public GameObject GetCheckpointB() => checkpointBlock;

    public void Deactivate() 
    {
        if (IsFinishLine() == false)
            ringTarget.GetComponent<MeshRenderer>().material.color = Color.clear;
        checkpointBlock.GetComponent<MeshRenderer>().material.color = Color.clear;
        color = "clear";
    }
    public void Activate()
    {
        if (IsFinishLine() == false)
            ringTarget.GetComponent<MeshRenderer>().material.color = Color.green;
        checkpointBlock.GetComponent<MeshRenderer>().material.color = Color.green;
        color = "green";
    }  
    public void SetRed()
    {
        if (IsFinishLine() == false)
            ringTarget.GetComponent<MeshRenderer>().material.color = Color.red;
        checkpointBlock.GetComponent<MeshRenderer>().material.color = Color.red;
        color = "red";
    }
    public void SetGreen()
    {
        if (IsFinishLine() == false)
            ringTarget.GetComponent<MeshRenderer>().material.color = Color.green;
        checkpointBlock.GetComponent<MeshRenderer>().material.color = Color.green;
        color = "green";
    }

    public string GetColor() => color;
    public bool IsDeactivated()
    {
        if (color == "clear")
            return true;
        return false;
    }

    public bool IsFinishLine()
    {
        if (ringTarget.tag == "Finish")
            return true;
        return false;
    }
}
public class Checkpoints
{
    private List<Checkpoint> checkpoints;
    public Checkpoints()
    {
        checkpoints = new List<Checkpoint>();
    }
    public Checkpoints(GameObject cps)
    {
        checkpoints = new List<Checkpoint>();
        for (int i = 0; i < cps.transform.childCount; i++)
        {
            GameObject cp = cps.transform.GetChild(i).transform.gameObject;
            AddCheckpoint(cp.transform.GetChild(3).transform.gameObject, cp.transform.GetChild(4).transform.gameObject);
        }
    }
    public void AddCheckpoint(GameObject r, GameObject c)
    {
        checkpoints.Add(new Checkpoint(r, c));
    }
    public void ResetCheckpoints()
    {
        checkpoints[0].SetGreen();
        for (int i = 1; i < checkpoints.Count; i++)
        {
            checkpoints[i].SetRed();
        }        
    }

    public Checkpoint this[int key]
    {
        get => checkpoints[key];
    }

    public int GetCount()
    {
        return checkpoints.Count;
    }
}
