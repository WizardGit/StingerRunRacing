using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;
using System;

public class PlayerController : MonoBehaviour
{
    public TextMeshProUGUI countText;
    public GameObject testText;
    private float time = 0.0f;
    public float playerRotationSpeed = 100f;
    public float playerSpeed = 10f;
    public float jumpForce = 400f;

    private int checkpointsReached = 0;

    private float movementX;
    private float movementY;
    Vector3 m_Movement;
    Vector2 inputDirection;

    Animation m_Animator;
    Rigidbody rb;

    void Start()
    {
        m_Animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        testText.SetActive(false);
    }

    private void OnMove(InputValue movementValue)
    {
        Vector2 movementVector = movementValue.Get<Vector2>();
        inputDirection = movementVector.normalized;

        movementX = movementVector.x;
        movementY = movementVector.y;        
    }

    private void OnJump()
    {
        Vector3 jump = new Vector3(movementX, jumpForce, movementY);        
        rb.AddForce(jump);
        m_Animator.Play("Jump01");
    }

    private void FixedUpdate()
    {
        time += Time.deltaTime;
        countText.text = "Count: " + MathF.Round(time,2);
        if (movementX > 0.0f)
            m_Animator.Play("WalkRight");
        else if (movementX < 0.0f)
            m_Animator.Play("WalkLeft");
        else if (!Mathf.Approximately(movementY, 0f))
            m_Animator.Play("Run");
        else
            m_Animator.Play("IdleHappy");

        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);
        rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);

        if (checkpointsReached == 1)
        {
            testText.SetActive(true);
            Application.Quit();
        }
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
