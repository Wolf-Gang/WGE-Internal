#include "math.as"
#include "speed.as"
#include "vector_tools.as"
#include "scoped_entity.as"
#include "narrative.as"
#include "follow_character.as"
#include "music.as"
#include "fx.as"
#include "entity.as"
#include "gui.as"


namespace player
{
	/// \weakgroup Player
	/// \{

	/// Set whether or not the player character will receive
	/// movement events (left, right, etc). When locked, the player will
	/// simply be unable to move.
	void lock(bool pIs_locked)
	{
		_set_player_locked(pIs_locked);
	}
	
	/// Check if player is locked
	bool is_locked()
	{
		return _get_player_locked();
	}
	
	/// Set the focus of the camera to either focus on the player
	/// or freely move around. When function like set_focus are used,
	/// the focus on the player is automatically removed.
	///
	/// This function can be called without any parameters to focus on player.
	void focus(bool pIs_focus = true)
	{
		focus_player(pIs_focus);
	}
	
	/// Unfocus player.
	void unfocus()
	{
		focus_player(false);
	}
	
	/// \}
}

/// \weakgroup Game
/// \{

/// Basic control that is supported in the engine.
/// There are 2 different types of controls: pressed and held.
/// Pressed controls are only activated once in only one frame and
/// in any other frame (even if it's still being held) it will not be considered
/// activated. Held controls are simply always activated when the key is down.
/// \see is_triggered
enum control
{
	activate = 0,     ///< Typically the enter and Z key (Pressed)
	left,             ///< (Held)
	right,            ///< (Held)
	up,               ///< (Held)
	down,             ///< (Held)
	select_next,      ///< Typically the right key (Pressed)
	select_previous,  ///< Typically the left key (Pressed)
	select_up,        ///< Typically the up key (Pressed)
	select_down,      ///< Typically the down key (Pressed)
	back,             ///< X key, go back or exit (Pressed)
	menu,             ///< Typically the M key (Pressed)
};

/// Check if a control as been activated
bool is_triggered(control pControls)
{
	return _is_triggered(pControls);
}
/// \}

/// \weakgroup Flags
/// \{


/// Exit thread if flag exists otherwise create the flag and continue.
/// This is useful in situations when you do not want a trigger to be activated more than one time.
/// \param pFlag Keyboard smash if you have no further use for it
void once_flag(const string&in pName)
{
	if (has_flag(pName))
		abort();
	set_flag(pName);
}

/// \}

