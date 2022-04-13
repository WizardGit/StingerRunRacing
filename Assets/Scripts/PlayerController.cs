using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{
    public Vector3 playerRotationSpeed = new Vector3(0, 100, 0);
    public float playerSpeed = 10f;

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
        Vector3 jump = new Vector3(movementX, 400.0f, movementY);        
        rb.AddForce(jump);
        m_Animator.Play("Jump01");
    }

    private void FixedUpdate()
    {
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

        Quaternion deltaRotation = Quaternion.Euler(movementX * playerRotationSpeed * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);
        rb.MovePosition(rb.position + transform.forward * playerSpeed * movementY * Time.deltaTime);
    }
}
