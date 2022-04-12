using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public Transform target;

    public Vector3 offsetPosition;

    public bool lookAt = true;

    private void Update()
    {
        transform.position = target.TransformPoint(offsetPosition);

        // compute rotation
        if (lookAt)
        {
            transform.LookAt(target);
        }
        else
            transform.rotation = target.rotation;
    }
}