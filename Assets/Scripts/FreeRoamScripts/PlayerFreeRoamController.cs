/*
 * Author: Kaiser Slocum
 * Last Modified: 9/5/2022
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;
using TMPro;
using UnityEngine.SceneManagement;

public class PlayerFreeRoamController : MonoBehaviour
{
    // Variables for keeping the time
    private float time = 0.0f;
    private float gemTimer = 0.0f;
    public List<Material> materials;
    public Image speedBar;
    public TextMeshProUGUI speedText;
    // Dictates if the player is allowed to move
    private bool isPause = false;
    // Dictates if the player is on the Terrain
    private bool onTerrain = false;
    // Leaderboard parent object
    public GameObject pauseMenu;
    // Camera Variables
    public Camera mainCamera;
    private CameraFollow cf;
    // Dictates the name of the player
    private string username;
    // These variables hold the animation title for the speedstinger
    private string animationRun = "Run";
    private string animationIdle = "IdleHappy";
    private string animationLeft = "WalkLeft";
    private string animationRight = "WalkRight";

    // Movement variables
    private float playerRotationSpeed = 200f;
    private float playerSpeed = 0;
    private float playerAcceleration = 0;
    private float playerMaxSpeed = 0;
    private float jumpForce = 1000;

    // Movement variables
    private float movementX;
    private float movementY;
    private float movementYBefore = 0.0f;
    // Dictates the last checkpoint that the player will reset to if it falls out of the map
    private Vector3 resetPos;
    private UserSave usersave;
    private LeaderboardSave ledsave;

    // Object variables
    Animation animator;
    Rigidbody rb;
    public AudioSource audioRoar;
    public AudioSource gemCollectSound;

    public TextMeshProUGUI messageText;

    // Variables for raycasting
    private float maxDistCast = 0.1f;
    private float radius = 0.2f;

    //Gem variables
    private int gemCount;

    void Start()
    {
        string theName = NameTransfer.theName;
        if (theName != null)
        {
            username = theName;
            Debug.Log("Username is " + username);
        }
        else
            Debug.Log("ERROR: no username!");

        // Load/Create a new file for this user!
        usersave = new UserSave(username);

        int modelToUse = usersave.IndexOfDragonInUse();

        // Load the correct skin!
        for (int i = 0; i < usersave.dragons[modelToUse].GetSkinsLength(); i++)
        {
            if (usersave.dragons[modelToUse].GetSkin(i) == "Using")
            {
                gameObject.transform.GetChild(0).gameObject.GetComponent<Renderer>().material = materials[i];
            }
        }

        animator = GetComponent<Animation>();
        rb = GetComponent<Rigidbody>();
        cf = mainCamera.GetComponent<CameraFollow>();

        speedText.text = "0 mph";
        resetPos = new Vector3(572.21f, 8.4f, 190.72f);

        playerRotationSpeed = usersave.dragons[modelToUse].GetTurnSpeed();
        playerMaxSpeed = usersave.dragons[modelToUse].GetSpeedForce();
        jumpForce = usersave.dragons[modelToUse].GetJumpForce();
        maxDistCast = usersave.dragons[modelToUse].GetMaxDistCast();
        radius = usersave.dragons[modelToUse].GetRadius();
        playerAcceleration = usersave.dragons[modelToUse].GetAccelForce();

        speedBar.fillAmount = 0.2f;
    }

    private void FixedUpdate()
    {
        // This code is vital for keeping the dragon rotated with the terrain
        RaycastHit hit;        
        Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out hit, 1f);

        if (Physics.SphereCast(transform.position, radius, -(transform.up), out hit, maxDistCast))
        {
            rb.MoveRotation(Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(Vector3.Cross(transform.right, hit.normal)), 10 * Time.deltaTime));
        }

        if (rb.position.y <= 0)
        {
            OnRespawn();
        }
        if (isPause == false)
        {
            time += Time.deltaTime;          
            Move();           
        }  
        if ((time - gemTimer) > 3)
        {
            messageText.text = "";
        }
    }

    private void Move()
    {
        // Animations - but only play if we're on ground
        if (onTerrain == true)
        {
            if (movementX > 0.0f)
                animator.Play(animationRight);
            else if (movementX < 0.0f)
                animator.Play(animationLeft);
            else if ((!Mathf.Approximately(movementY, 0f) || !Mathf.Approximately(movementX, 0f) || (playerSpeed > 0)) && (onTerrain == true))
                animator.Play(animationRun);
            else
            {
                // The shoot-fireball animation should not be interrupted by animationIdle
                if (animator.IsPlaying("FlyAttackAdd") == false)
                    animator.Play(animationIdle);
            }
        }

        if (!Mathf.Approximately(movementY, 0f) && (playerSpeed <= playerMaxSpeed))
        {
            if ((playerSpeed + (playerAcceleration * Time.deltaTime)) > playerMaxSpeed)
                playerSpeed = playerMaxSpeed;
            else
                playerSpeed += playerAcceleration * Time.deltaTime;
        }
        else if ((Mathf.Approximately(movementY, 0f) && (playerSpeed > 0)) || (playerSpeed > playerMaxSpeed))
        {
            playerSpeed -= (playerAcceleration * 2) * Time.deltaTime;
            if (playerSpeed < 0)
                playerSpeed = 0;
        }

        speedBar.fillAmount = playerSpeed / playerMaxSpeed;
        speedText.text = MathF.Round(playerSpeed, 2).ToString() + " mph";

        // Move our rigid body's rotation
        Vector3 vecRotation = new Vector3(0, playerRotationSpeed, 0);
        Quaternion deltaRotation = Quaternion.Euler(movementX * vecRotation * Time.deltaTime);
        rb.MoveRotation(rb.rotation * deltaRotation);

        // If the player is backing up, they shouldn't be able to go all that fast!
        if (movementY < 0)
            rb.MovePosition(rb.position + transform.forward * (playerSpeed / 2) * movementYBefore * Time.deltaTime);
        else
            rb.MovePosition(rb.position + transform.forward * playerSpeed * movementYBefore * Time.deltaTime);
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("GemPickup"))
        {
            other.gameObject.SetActive(false);
            other.gameObject.transform.parent.gameObject.GetComponent<GemScript>().UpdateGemCollected();
            gemCollectSound.Play();
            messageText.text = "You just earned 10 gems!";
            gemTimer = time;
        }
        else if (other.gameObject.CompareTag("SwordPickup"))
        {
            other.gameObject.SetActive(false);
            audioRoar.Play();
            messageText.text = "You just destroyed the sword! \n Great job.";
            gemTimer = time;
        }
    }

    // As long as we have a collision, we are "on the terrain"
    private void OnCollisionEnter(Collision theCollision)
    {
        onTerrain = true;
        if (theCollision.gameObject.CompareTag("Water"))
        {
            // We are in water, so switch our animations
            animationRun = "Swim";
            animationIdle = "SwimIdle";
            animationLeft = "Swim";
            animationRight = "Swim";
        }
    }
    // As long as we have exited a collision, we must be "in the air"
    private void OnCollisionExit(Collision theCollision)
    {
        if (theCollision.gameObject.CompareTag("Water"))
        {
            // We are exiting the water, so switch our animations
            animationRun = "Run";
            animationIdle = "IdleHappy";
            animationLeft = "WalkLeft";
            animationRight = "WalkRight";
        }
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
        if ((onTerrain == true) && (isPause == false))
        {
            Vector3 jump = new Vector3(movementX, jumpForce, movementY);
            rb.AddForce(jump);
            onTerrain = false;
            animator.Play("Jump01");
        }
    }
    private void OnRespawn()
    {
        rb.MovePosition(resetPos);
    }
    private void OnLookAt()
    {
        cf.lookAt = !cf.lookAt;
    }
    private void OnFrontView()
    {
        // If we're looking at the object, we need to get in front of it (so we'll reverse our z offset
        cf.lookForward = !cf.lookForward;
        cf.offsetPosition.z = cf.offsetPosition.z * -1.0f;
    }
    private void OnPause()
    {
        // Note sure how to handle when a user releases a key so this is my workaround! User pushes once to get the pause menu, then pushes again to get out of it
        // 
       
            isPause = !isPause;
            animator.Stop();
            PauseMenu men = pauseMenu.GetComponent<PauseMenu>();
            if (isPause == true)
                men.PauseGame();
            else
                men.ResumeGame();

    }
    private void OnRoar()
    {
        audioRoar.Play();
    }
    private void OnFire()
    {
        if (Mathf.Approximately(movementY, 0f) && Mathf.Approximately(movementX, 0f) && (animator.IsPlaying("FlyAttackAdd") == false))
        {
            animator.Play("FlyAttackAdd");
            gameObject.transform.GetChild(4).gameObject.GetComponent<ParticleSystem>().Play();
            OnRoar();
        }
    }

    private void OnClick()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        // If the user clicks on Harald, check for the quests
        if ((Physics.Raycast(ray, out hit) == true) && (hit.transform.CompareTag("Harald")))
            hit.transform.gameObject.GetComponent<HaraldMove>().HandleQuests();
    }
}