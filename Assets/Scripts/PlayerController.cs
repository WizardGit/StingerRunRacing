using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerController : MonoBehaviour
{
    public float playerRotationSpeed = 20f;
    public float playerSpeed = 10f;

    private float movementX;
    private float movementY;

    Animation m_Animator;

    void Start()
    {
        m_Animator = GetComponent<Animation>();
    }

    private void OnMove(InputValue movementValue)
    {
        Vector2 movementVector = movementValue.Get<Vector2>();

        movementX = movementVector.x;
        movementY = movementVector.y;

    }
    private void OnJump()
    {
        Vector3 jump = new Vector3(movementX, 400.0f, movementY);
        Rigidbody rb = GetComponent<Rigidbody>();
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

        transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);
    }
}
