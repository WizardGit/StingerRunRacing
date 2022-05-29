/*
 * Author: Kaiser Slocum
 * Last Modified: 5/29/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadingRotater : MonoBehaviour
{
    public GameObject gear;

    // Update is called once per frame
    void FixedUpdate()
    {
        gear.transform.Rotate(new Vector3(0, 0,150) * Time.deltaTime);
    }
}
