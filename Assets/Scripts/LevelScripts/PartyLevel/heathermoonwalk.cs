/*
 * Author: Kaiser Slocum
 * Last Modified: 9/24/2022
 * Script for heather moonwalk
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class heathermoonwalk : MonoBehaviour
{
    public NavMeshAgent navMeshAgent;
    public GameObject waypoints;

    // Variables needed just for the script
    private Rigidbody rb;
    public int speed;
    private bool rotating = false;
    private int rotatT = 0;

    // Start is called before the first frame update
    void Start()
    {
        rb = gameObject.GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        //Debug.Log(rb.position + transform.forward * speed * 1 * Time.deltaTime);
        if (rotating == false)
            rb.MovePosition(rb.position + transform.forward * speed * -1 * Time.deltaTime);
        else
        {

            gameObject.transform.rotation = Quaternion.RotateTowards(gameObject.transform.rotation, Quaternion.Euler(new Vector3(0, rotatT, 0)), 200 * Time.deltaTime);
            if (gameObject.transform.rotation == Quaternion.Euler(new Vector3(0, rotatT, 0)))
            {
                rotating = false;
            }
        }
    }
    private void OnTriggerEnter(Collider other)
    {
       if (other.gameObject.CompareTag("cube"))
        {
            rotating = true;
            rotatT = 270;
        }
       else if (other.gameObject.CompareTag("cub2"))
        {
            rotating = true;
            rotatT = 90;
        }
    }
}
