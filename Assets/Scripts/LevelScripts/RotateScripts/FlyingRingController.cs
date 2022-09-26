/*
 * Author: Kaiser Slocum
 * Last Modified: 9/25/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyingRingController : MonoBehaviour
{
    public GameObject bladeLeft;
    public GameObject bladeRight;
    public GameObject glowingRingTarget;
    
    void FixedUpdate()
    {
        bladeLeft.transform.Rotate(new Vector3(0, 400, 0) * Time.deltaTime);
        bladeRight.transform.Rotate(new Vector3(0, 400, 0) * Time.deltaTime);
        glowingRingTarget.transform.Rotate(new Vector3(0, 50, 0) * Time.deltaTime);
    }
}
