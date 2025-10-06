using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

/// Description:
/// Simple reusable component to play UI click sounds.
/// Attach this to a GameObject in the scene (for example an "Audio" or "Managers" object)
/// and assign an AudioSource plus one or more AudioClips. Call PlayClick() from
/// UI Button OnClick() or wire it up from code.

[DisallowMultipleComponent]
public class UIAudioPlayer : MonoBehaviour
{
    [Tooltip("AudioSource used to play UI sounds. If empty, one will be created on this GameObject.")]
    public AudioSource audioSource;

    [Tooltip("Default click sound. Can be left empty if you prefer to set clips per-button.")]
    public AudioClip defaultClick;

    [Header("Playback restrictions")]
    [Tooltip("If true, UI sounds will only play when the active scene name matches `menuSceneName` or when the PauseMenu is active (if allowWhenPaused is true).")]
    public bool playOnlyInMenu = true;

    [Tooltip("Name of the scene considered the main menu. Used when playOnlyInMenu is enabled.")]
    public string menuSceneName = "Menu";

    [Tooltip("If true, UI sounds are allowed while the PauseMenu.isPaused is true (useful for pause menu button clicks).")]
    public bool allowWhenPaused = true;

    void Reset()
    {
        // ensure there's an AudioSource with sensible defaults for UI sounds
        if (audioSource == null)
        {
            audioSource = gameObject.GetComponent<AudioSource>();
            if (audioSource == null) audioSource = gameObject.AddComponent<AudioSource>();
        }

        audioSource.playOnAwake = false;
        audioSource.spatialBlend = 0f; // 2D sound
        audioSource.rolloffMode = AudioRolloffMode.Linear;
    }

    /// Description:
    /// Play the default click sound (if assigned).
    /// Hook this method to a UI Button OnClick() via the inspector.
    /// </summary>
    /// Play the default click sound (if assigned).
    /// Hook this method to a UI Button OnClick() via the inspector.
    /// </summary>
    public void PlayClick()
    {
        if (!ShouldPlay()) return;
        if (audioSource == null) return;
        if (defaultClick == null) return;
        audioSource.PlayOneShot(defaultClick);
    }

    /// <summary>
    /// Play a specific clip. Useful for assigning different sounds per button.
    /// </summary>
    public void PlayClip(AudioClip clip)
    {
        if (!ShouldPlay()) return;
        if (audioSource == null || clip == null) return;
        audioSource.PlayOneShot(clip);
    }

    bool ShouldPlay()
    {
        // If there is no restriction, always play
        if (!playOnlyInMenu) return true;

        // Allow if current scene is the configured menu scene
        var active = SceneManager.GetActiveScene();
        if (string.Equals(active.name, menuSceneName, System.StringComparison.OrdinalIgnoreCase))
            return true;

        // Allow if pause menu is active AND the inspector allows it
        if (allowWhenPaused)
        {
            // PauseMenu exposes a static isPaused boolean — use it if available
            try
            {
                if (PauseMenu.isPaused) return true;
            }
            catch { /* If PauseMenu isn't present, ignore. */ }
        }

        // Otherwise don't play
        return false;
    }
}