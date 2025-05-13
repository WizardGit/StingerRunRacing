/*
 * Author: Kaiser Slocum
 * Last Modified: 5/12/2025
 * Purpose: Prevent players from weirdly resizing the screen
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraZoom : MonoBehaviour
{
    public float targetAspectRatio = 16f / 9f;

    private Camera cam;

    // Start is called before the first frame update
    void Start()
    {
        cam = GetComponent<Camera>();
        UpdateCameraViewport();
    }

    // Update is called once per frame
    private void Update()
    {
        // Optionally check if screen resized, then update again
        if (Mathf.Abs(((float)Screen.width / Screen.height) - targetAspectRatio) > 0.01f)
        {
            UpdateCameraViewport();
        }
    }

    void UpdateCameraViewport()
    {
        float windowAspect = (float)Screen.width / Screen.height;
        float scaleHeight = windowAspect / targetAspectRatio;


        if (scaleHeight < 1.0f)
        {
            // Add letterbox (horizontal bars)
            Rect rect = new Rect(0, (1.0f - scaleHeight) / 2.0f, 1, scaleHeight);
            cam.rect = rect;
        }
        else
        {
            // Add pillarbox (vertical bars)
            float scaleWidth = 1.0f / scaleHeight;
            Rect rect = new Rect((1.0f - scaleWidth) / 2.0f, 0, scaleWidth, 1);
            cam.rect = rect;
        }
    }
}
