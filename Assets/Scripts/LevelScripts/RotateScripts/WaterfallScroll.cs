/*
 * Author: Kaiser Slocum
 * Last Modified: 5/8/2025
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterfallScroll : MonoBehaviour
{
    public float scrollSpeed = 0.5f;
    private Renderer rend;
    private Vector2 offset;

    void Start()
    {
        rend = GetComponent<Renderer>();
    }

    void FixedUpdate()
    {
        offset.y += scrollSpeed * Time.deltaTime;
        rend.material.mainTextureOffset = offset;
    }
}

