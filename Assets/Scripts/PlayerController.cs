/*
 * Author: Kaiser Slocum
 * Date last edited: 4/18/2022
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;
using System;

public class PlayerController : MonoBehaviour
{
    // Variables for keeping the time
    private float time = 0.0f;
    private float countdown = 0.0f;
    private bool start = false;
    private bool onTerrain = false;
    public int numCheckpoints;
    private float boostTimer;

    // Movement speeds
    public float playerRotationSpeed = 100f;
    public float playerSpeed = 10f;
    public float jumpForce = 400f;    

    // How many checkpoints have we hit!
    private int checkpointsReached = 0;

    // Movement variables
    private float movementX;
    private float movementY;    

    // Object variables
    Animation animator;
    Rigidbody rb;

    // Text variables
    public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;

    private Vector3 resetPos;

    void Start()
    {
        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        timeText.text = "Time: 0";
        resetPos = new Vector3(1737f, 107.79f, 1534f);
    }

    private void OnMove(InputValue movementValue)
    {
        Vector2 movementXY = movementValue.Get<Vector2>().normalized;
        movementX = movementXY.x;
        movementY = movementXY.y;        
    }

    private void OnJump()
    {
        if ((onTerrain == true) && (start == true))
        {            
            Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            animator.Play("Jump01");
        }     
    }

    private void FixedUpdate()
    {
        if (rb.position.y <= 0)
        {
            rb.MovePosition(resetPos);
        }
        if ((time - boostTimer) > 20f)
        {
            playerSpeed = 10f;
        }
        else if ((time - boostTimer) > 2f)
        {
            messageText.text = "";
        }
            if (start == false)
        {
            countdown += Time.deltaTime;
            messageText.text = (3-MathF.Round(countdown)).ToString();
            if (countdown >= 2.5f)
            {
                start = true;
                messageText.text = "<size=200%> GO!";
            }
        }
        else
        {
            time += Time.deltaTime;
            timeText.text = "Time: " + MathF.Round(time, 2);
            move();

            if ((time > 3.0f) && (start == true) && (messageText.text == "<size=200%> GO!") && (messageText.text != ""))
            {
                messageText.text = "";
            }
        }

        // Keep for later in case we need it!
        //RaycastHit hit;
        //Ray checkGround = new Ray(transform.position, Vector3.down);
        //if ((inJump == true) && (Physics.Raycast(checkGround, out hit, 0.81f)) && ((hit.collider.tag == "GroundTerrain") || (hit.collider.tag == "Untagged")))
        //{
            //inJump = false;
        //}
    }
    private void move()
    {
        if (movementX > 0.0f)
            animator.Play("WalkRight");
        else if (movementX < 0.0f)
            animator.Play("WalkLeft");
        else if (!Mathf.Approximately(movementY, 0f))
            animator.Play("Run");
        else
            animator.Play("IdleHappy");

        // We can use transform instead of rigidbody
        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);
        rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);
    }
    private void OnTriggerEnter(Collider other)
    {
        if ((other.gameObject.CompareTag("RingTarget")) && (other.gameObject.GetComponent<MeshRenderer>().material.color == Color.green))
        {
            resetPos = other.gameObject.transform.position;
            other.gameObject.SetActive(false);
            checkpointsReached++;
        }
        else if (other.gameObject.CompareTag("FlyingBox"))
        {
            other.gameObject.SetActive(false);
            playerSpeed = 20f;
            messageText.text = "<size=200%> Double Speed!";
            boostTimer = time;
            // Do Something like speed boost
        }
        else if ((other.gameObject.CompareTag("Finish")) && (checkpointsReached == numCheckpoints))
        {
            messageText.text = "<size=200%> Finished!";
            other.gameObject.SetActive(false);
            Application.Quit();
        }
    }

    // These methods detect if player is on the terrain!
    private void OnCollisionEnter(Collision theCollision)
    {
        if (theCollision.gameObject.name == "Terrain")
        {
            onTerrain = true;
        }
        else
        {
            onTerrain = true;
        }
    }
    private void OnCollisionExit(Collision theCollision)
    {
        if ((theCollision.gameObject.name == "Terrain") || (theCollision.gameObject.CompareTag("Untagged")))
        {
            onTerrain = false;
        }
    }
}
