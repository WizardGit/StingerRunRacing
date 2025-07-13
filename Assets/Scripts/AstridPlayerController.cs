/*
 * Author: Kaiser Slocum
 * Last Modified: 7/12/2025
 * Purpose: Controls player movements
 */

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;

public class AstridPlayerController : MonoBehaviour
{   
    [HideInInspector] public Camera mainCamera;
    [HideInInspector] public CameraFollowHuman cf;
    [HideInInspector] public Animator anim;
    // Dictates if the player is allowed to move
    [HideInInspector] public bool isPause = false;
    [HideInInspector] public bool canRun = false;
    // Variables for what kind of material the player is on
    public bool onTerrain = true;
    public bool inWater = false;
    public bool onWaterCube = false;

    // Dragon stat variables that depends on the dragon's class stats
    private float playerRotationSpeed = 200f;
    [HideInInspector] public float playerSpeed = 0;
    private float playerAcceleration = 0;
    [HideInInspector] public bool isAccelerating = false;
    [HideInInspector] public float playerMaxSpeed = 0;
    [HideInInspector] public float origPlayerMaxSpeed = 0;
    [HideInInspector] public float playerMinOnWaterSpeed = 14;
    private float jumpForce = 1000;

    // Movement variables
    [HideInInspector] public float movementX = 0.0f;
    [HideInInspector] public float movementY = 0.0f;
    private float movementYBefore = 0.0f;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    [HideInInspector] public Vector3 resetPos;
    // The object that holds the save file for the user
    private SaveGame theSave;

    // Object variables
    private Rigidbody rb;
    private AudioSource audioRoar;

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    // Water Box variables
    private float waterPos;
    public float dragonWaterHeight;

    void Start()
    {
        // Load/Create a new file for this theSave!
        theSave = GameObject.Find("SaveGameObject").GetComponent<SaveGame>();
        
        waterPos = GameObject.FindGameObjectWithTag("Water").gameObject.transform.position.y;

        mainCamera = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();

        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollowHuman>();
        audioRoar = GetComponent<AudioSource>();
        anim = GetComponent<Animator>();        

        resetPos = transform.position;       

        playerRotationSpeed = 180f;
        playerMaxSpeed = 20f * (transform.localScale.x);
        origPlayerMaxSpeed = 20f * (transform.localScale.x);

        jumpForce = 1000f;
        maxDistCast = 0.09f;
        radius = 0.3f;
        playerAcceleration = 13f * (transform.localScale.x);   
        dragonWaterHeight = 0.8f;

        SetAnimatorBool("isIdleHappy");
    }    

    private void FixedUpdate()
    {
        //Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);
        // This code is vital for keeping the dragon rotated with the terrain
        if (Physics.SphereCast(transform.position, radius, -(transform.up), out RaycastHit hit, maxDistCast))
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)), 4 * Time.deltaTime));

        // If the user falls under the map
        if (rb.position.y <= -2)
            OnRespawn();

        if (isPause == false)
            Move();
    }
    
    private void Move()
    {
        if (inWater == true)
        {
            if (playerSpeed < playerMinOnWaterSpeed)
            {
                ClampVelocity(waterPos - dragonWaterHeight);

                if (rb.position.y <= waterPos)
                {
                    if (playerSpeed > 0)
                        SetAnimatorBool("isSwim");
                    else
                        SetAnimatorBool("isSwimIdle");
                }                
            }
            else if (playerSpeed >= playerMinOnWaterSpeed)
            {
                Debug.Log("Clamp speed!");
                ClampVelocity(waterPos);
                SetAnimatorBool("isRun");
            }
        }     

        // Animations - but only play if we're on ground
        if (((onTerrain == true) && (inWater == false)) || ((inWater == true) && (playerSpeed >= playerMinOnWaterSpeed)))
        {    
            if (movementX > 0.0f)
                SetAnimatorBool("isTurnRight");
            else if (movementX < 0.0f)
                SetAnimatorBool("isTurnLeft");
            else if (!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f) || (playerSpeed > 0))
                SetAnimatorBool("isRun");
            else
            {
                if (anim.GetCurrentAnimatorStateInfo(0).IsName("Attack") == true)
                {
                    //SetAnimatorBool("isAttack");
                }
                else
                {
                    //Debug.Log("Current state is: " + anim.GetCurrentAnimatorStateInfo(0).shortNameHash.ToString());
                    SetAnimatorBool("isIdleHappy");
                }
            }
        }
        // &&((onTerrain==true) || (inWater==true))
        if (!Mathf.Approximately(movementY, 0f) && (playerSpeed <= playerMaxSpeed))
        {
            // Check our player speed to see if we can add on more
            if ((playerSpeed + (playerAcceleration * Time.deltaTime)) > playerMaxSpeed)
            {
                playerSpeed = playerMaxSpeed;
                cf.GetComponent<CameraFollowHuman>().isAccel = false;
            }                
            else
            {
                playerSpeed += playerAcceleration * Time.deltaTime;
                cf.GetComponent<CameraFollowHuman>().isAccel = true;
            }                
        }
        else
        {
            cf.GetComponent<CameraFollowHuman>().isAccel = false;

            if (((Mathf.Approximately(movementY, 0f) && (playerSpeed > 0)) || (playerSpeed > playerMaxSpeed)) )
            {
                playerSpeed -= (playerAcceleration * 2) * Time.deltaTime;
                if (playerSpeed < 0)
                    playerSpeed = 0;
            }
        }

        // We can use transform instead of rigidbody
        //transform.Translate(0, 0, movementY * playerSpeed * Time.deltaTime);
        //transform.Rotate(0, movementX * playerRotationSpeed * Time.deltaTime, 0);

        // Move our rigid body's rotation
        Quaternion deltaRotation = Quaternion.Euler(movementX * Time.deltaTime * (new Vector3(0, playerRotationSpeed, 0)));
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
            rb.MovePosition(rb.position + (playerSpeed/2) * movementYBefore * Time.deltaTime * transform.forward);
        else
            rb.MovePosition(rb.position + movementYBefore * playerSpeed * Time.deltaTime * transform.forward);
    }

    private void ClampVelocity(float heightPos)
    {        
        // Clamp Y position to minimum of heightPos
        if (rb.position.y < heightPos)
        {
            Vector3 velocity = rb.velocity;

            if (velocity.y < 0)
            {
                velocity.y = 0;
                rb.velocity = velocity;
            }
            rb.AddForce(-Physics.gravity * rb.mass);

            Vector3 pos = rb.position;
            pos.y = heightPos;
            rb.MovePosition(Vector3.Lerp(rb.position, pos, 0.05f));

            // Current rotation
            Quaternion currentRotation = rb.rotation;

            // Desired upright rotation: keep Y, zero out X and Z
            Vector3 currentEuler = currentRotation.eulerAngles;
            Quaternion targetRotation = Quaternion.Euler(0f, currentEuler.y, 0f);

            // Smoothly interpolate to upright rotation
            Quaternion newRotation = Quaternion.Slerp(currentRotation, targetRotation, Time.deltaTime * 4);

            rb.MoveRotation(newRotation);
        }
    }
    private void OnTriggerEnter(Collider triggerObj)
    {
        if (triggerObj.gameObject.CompareTag("Water"))
        {
            Debug.Log("Water!");
            onTerrain = false;
            inWater = true;            
        }
    }

    private void OnTriggerExit(Collider triggerObj)
    {
        if (triggerObj.gameObject.CompareTag("Water"))
        {
            //Leave Water
            if (waterPos < rb.position.y)
                inWater = false;

            anim.SetBool("isSwim", false);
            anim.SetBool("isSwimIdle", false);
        }
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision collidingObj)
    {
        if ((collidingObj.gameObject.tag == "GroundTerrain") || (collidingObj.gameObject.layer == 3))
        {
            onTerrain = true;
            anim.SetBool("isJump", false);
        }
    }
    // As long as we have exited a collision, we must be "in the air"
    private void OnCollisionExit(Collision collidingObj)
    {
        Debug.Log(collidingObj.gameObject.name);
        if ((collidingObj.gameObject.tag == "GroundTerrain") || (collidingObj.gameObject.layer == 3))
            onTerrain = false;
    }
    
    // Some extra Key Bindings
    private void OnMove(InputValue movementValue)
    {
        Vector2 movementXY = movementValue.Get<Vector2>().normalized;
        movementX = movementXY.x;
        movementY = movementXY.y;
        if (!Mathf.Approximately(movementY, 0f))
            movementYBefore = movementY;
    }
    private void OnJump()
    {
        Debug.Log("OnTerrain: " + onTerrain);
        if ((onTerrain == true) && (isPause == false))
        {
            onTerrain = false;
            Vector3 jump = new(movementX, jumpForce, movementY);
            rb.AddForce(jump);            
            SetAnimatorBool("isJump");            
        }
        else if ((inWater == true) && (isPause == false) && (playerSpeed >= playerMinOnWaterSpeed))
        {
            onTerrain = false;
            Vector3 jump = new(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            SetAnimatorBool("isJump");
        }
    }
    private void OnRespawn()
    {
        rb.MovePosition(resetPos);
    }
    private void OnLookAt()
    {
       if (isPause == false)
            cf.lookAt = !cf.lookAt;
    }

    private void OnAttack()
    {
        SetAnimatorBool("isAttack");
    }
    private void OnFrontView()
    {
        if (isPause == false)
        {
            // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
            cf.lookForward = !cf.lookForward;
            cf.offsetPosition.z *= -1.0f;
        }        
    }
    public void CanStart(bool canStart)
    {
        canRun = canStart;
        if (canStart == true)
            isPause = false;
        else
            isPause = true;
    }
    public void OnRoar()
    {        
        if (audioRoar.isPlaying == false)
            audioRoar.Play();
    }  

    public void SetAnimatorBool(string blnAnim)
    {
        
        // This works assuming that we don't directly set the bools anywhere else in the code...
        if (anim.GetBool(blnAnim) == false)
        {
            Debug.Log("NewAnim");
            anim.SetBool("isJump", false);
            anim.SetBool("isSwimIdle", false);
            anim.SetBool("isSwim", false);
            anim.SetBool("isRun", false);
            anim.SetBool("isWalk", false);
            anim.SetBool("isTurnLeft", false);
            anim.SetBool("isTurnRight", false);
            anim.SetBool("isIdleHappy", false);
            anim.SetBool("isAttack", false);
            anim.SetBool(blnAnim, true);
        }        
    }
}
