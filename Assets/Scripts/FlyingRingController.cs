using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyingRingController : MonoBehaviour
{
    public GameObject bladeLeft;
    public GameObject bladeRight;
    public GameObject glowingRingTarget;
    
    void Update()
    {
        bladeLeft.transform.Rotate(new Vector3(0, 200, 0) * Time.deltaTime);
        bladeRight.transform.Rotate(new Vector3(0, 200, 0) * Time.deltaTime);
        glowingRingTarget.transform.Rotate(new Vector3(0, 50, 0) * Time.deltaTime);
    }
}
