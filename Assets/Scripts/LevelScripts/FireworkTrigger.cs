using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireworkTrigger : MonoBehaviour
{
    public GameObject fireleft;
    public GameObject fireright;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player") == true)
        {
            fireleft.SetActive(true);
            fireright.SetActive(true);
        }
    }
}
