using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireworkTrigger : MonoBehaviour
{
    public GameObject fireleft;
    public GameObject fireright;
    public GameObject checkpoints;

    private void OnTriggerEnter(Collider other)
    {
        if ((other.gameObject.CompareTag("Player") == true) && (other.gameObject.GetComponent<PlayerController>().checkpointsReached == checkpoints.transform.childCount))
        {
            fireleft.SetActive(true);
            fireright.SetActive(true);
        }
    }
}
