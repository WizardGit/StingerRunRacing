/* Created by Kaiser Slocum
 * Last Edited on 4/14/2022 by Kaiser Slocum
 * Purpose: To constantly modify the camera's positioning on the object
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class CameraFollow : MonoBehaviour
{
    public Transform target;

    public Vector3 offsetPosition;
    public Vector3 offsetRotation;

    public bool lookAt = true;

    private bool check = false;

    private void OnFrontView()
    {
        if (lookAt)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            offsetPosition.z = offsetPosition.z * -1.0f;
        }  
        else
        {
            // We need to signal to Update method to rotate by 180 degrees
            check = !check;
        }
    }

    private void Update()
    {        
        // Get where our camera needs to be
        transform.position = target.TransformPoint(offsetPosition);

        // If we want to actually look at the object...
        if (lookAt)
        {
            // Then Calculate camera rotation
            // I feel like this is a bit clunky though!
            transform.LookAt(target);
            Vector3 targetRotation = transform.rotation.eulerAngles;
            Vector3 transformRotation = new Vector3(targetRotation.x-offsetRotation.x, targetRotation.y- offsetRotation.y, targetRotation.z- offsetRotation.z);
            transform.rotation = Quaternion.Euler(transformRotation);
        }
        else
        {
            if (check)
            {
                // The camera needs to be in our object but rotated by 180 degrees
                Vector3 targetRotation = target.rotation.eulerAngles;
                Vector3 transformRotation = new Vector3(targetRotation.x, targetRotation.y + 180, targetRotation.z);
                transform.rotation = Quaternion.Euler(transformRotation);
            }
            else
            {
                transform.rotation = target.rotation;
            }            
        }            
    }
}