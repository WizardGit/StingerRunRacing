/*
 * Author: Kaiser Slocum
 * Last Modified: 5/14/2025
 * Script for moving a narwhal within their pod
 */

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NarwhalSwim : MonoBehaviour
{
    // Reference to the group (parent object)
    private Transform groupTransform;         

    // Variables needed just for the script
    private Rigidbody rb;
    public int narwhalSpeed = 4;
    public int rotateSpeed = 2;
    // How tightly it follows its target spot
    public float followStrength = 1f;
    // Initial local position relative to group
    private Vector3 localOffset;             

    // Start is called before the first frame update
    void Start()
    {
        groupTransform = gameObject.transform.parent.gameObject.transform;
        rb = gameObject.GetComponent<Rigidbody>();
        localOffset = groupTransform.InverseTransformPoint(transform.position);
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Vector3 targetWorldPos = groupTransform.TransformPoint(localOffset);

        Vector3 direction = (targetWorldPos - transform.position);
        Vector3 moveDir = direction.normalized;

        // Move
        Vector3 nextPos = rb.position + moveDir * narwhalSpeed * Time.fixedDeltaTime * followStrength;
        rb.MovePosition(nextPos);

        // Rotate to face movement direction
        if (moveDir != Vector3.zero)
        {
            Quaternion lookRot = Quaternion.LookRotation(moveDir);
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, lookRot, Time.fixedDeltaTime * rotateSpeed));
        }     
    }
}
