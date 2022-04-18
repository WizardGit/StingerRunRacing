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

    // Movement speeds
    public float playerRotationSpeed = 100f;
    public float playerSpeed = 10f;
    public float jumpForce = 400f;    

    // How many checkpoints have we hit!
    private int checkpointsReached = 0;
    private bool inJump = false;

    // Movement variables
    private float movementX;
    private float movementY;

    // Object variables
    Animation animator;
    Rigidbody rb;

    // Text variables
    public TextMeshProUGUI timeText;
    public TextMeshProUGUI messageText;

    void Start()
    {
        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();

        timeText.text = "";
    }

    private void OnMove(InputValue movementValue)
    {
        Vector2 movementXY = movementValue.Get<Vector2>().normalized;
        movementX = movementXY.x;
        movementY = movementXY.y;        
    }

    private void OnJump()
    {
        if ((inJump == false) && (start == true))
        {
            inJump = true;
            Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            animator.Play("Jump01");
        }
        else
        {
            RaycastHit hit;
            Ray checkGround = new Ray(transform.position, Vector3.down);

            if ((inJump == true) && (Physics.Raycast(checkGround, out hit, 1f)) && ((hit.collider.tag == "GroundTerrain") || (hit.collider.tag == "Untagged")))
            {
                inJump = false;
            }
        }        
    }

    private void FixedUpdate()
    {
        if (rb.position.y <= 0)
        {
            Vector3 resetPos = new Vector3(1805f, 108.82f, 1538f);
            rb.MovePosition(resetPos);
        }
        if (start == false)
        {
            countdown += Time.deltaTime;
            messageText.text = (3-MathF.Round(countdown)).ToString();
            if (countdown >= 0.0f)
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

            if ((time > 2.0f) && (start == true) && (messageText.text == "<size=200%> GO!") && (messageText.text != ""))
            {
                messageText.text = "";
            }
            if (checkpointsReached == 1)
            {
                messageText.text = "<size=200%> Finished!";
                Application.Quit();
            }
        }        
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

        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);
        rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("RingTarget"))
        {
            other.gameObject.SetActive(false);
            checkpointsReached++;
        }
    }
}
