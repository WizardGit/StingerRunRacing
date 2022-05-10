using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpinCycle : MonoBehaviour
{
    void FixedUpdate()
    {
        gameObject.transform.Rotate(new Vector3(0, 150, 0) * Time.deltaTime);
    }
}
