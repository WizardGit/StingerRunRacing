/*
 * Authors: Kaiser Slocum
 * Last Modified: 5/14/2025
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireballCollision : MonoBehaviour
{
    private ParticleSystem PSystem;
    private List<ParticleCollisionEvent> CollisionEvents;
    private AudioSource explosionAudio;
    public ParticleSystem explosionEffect;

    // Start is called before the first frame update
    void Start()
    {
        explosionAudio = GetComponent<AudioSource>();
        CollisionEvents = new List<ParticleCollisionEvent>();
        PSystem = GetComponent<ParticleSystem>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public void OnParticleCollision(GameObject other)
    {
        Debug.Log("Collsion Tag: " + other.tag + " Collision Name: " + other.name + " //");
        int collCount = PSystem.GetSafeCollisionEventSize();

        if (collCount > CollisionEvents.Count)
            CollisionEvents = new List<ParticleCollisionEvent>();

        int eventCount = PSystem.GetCollisionEvents(other, CollisionEvents);

        for (int i = 0; i < eventCount; i++)
        {    
            explosionEffect.transform.position = CollisionEvents[i].intersection;

            // Reset rotation
            explosionEffect.transform.rotation = Quaternion.identity;

            explosionEffect.Play();
            explosionAudio.Play();

            // You can simply use "other" GameObject to access it's rigidbody to apply force, or check if it implements a class that takes damage or whatever
        }
    }
}
