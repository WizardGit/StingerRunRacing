using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestAction : MonoBehaviour
{
    private float movementX = 0.0f;
    private float movementY = 0.0f;
    private float jumpForce = 1300;
    private Rigidbody rb;
    public bool isWalk = false;
    public bool isRun = false;
    public bool isTurnLeft = false;
    public bool isTurnRight = false;
    public bool isSwim = false;
    public bool isSwimIdle = false;
    public bool isIdleSit = false;
    public bool isJump = false;
    public bool isIdleHappy = false;
    public Animator anim;





    // Start is called before the first frame update
    void Start()
    {
        isIdleHappy = true;
        rb = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
        anim.SetBool("isIdleHappy",true);

    }

    // Update is called once per frame
    void FixedUpdate()
    {
        
    }
    private void OnJump()
    {
        isJump = true;
        isIdleHappy = false;
        anim.SetBool("isIdleHappy", false);
        anim.SetBool("isJump", true);
        Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
        
    }
    private void OnFrontView()
    {
        //anim.SetBool("isIdleHappy", false);
        //anim.SetBool("isRun", true);

        anim.SetBool("isIdleHappy", true);

        anim.SetBool("isJump", false);
    }
}
