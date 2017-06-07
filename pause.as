
#include "menu.as"
//i kinda don't want to do this...but stats
#include "../scenes/backend/user_data.as"

[start]
void check_pause() {
  
  do {
    
    if(is_triggered("menu"))
      open_menu();
    
  } while(yield());
  
}


const vec pause_menu_position = pixel(35, 27);
const vec pause_option_size   = pixel(60, 20);

void open_menu()
{
  array<string> pause_options = {"Stats", "Items"};
  list_menu pause_menu (pause_options, pause_menu_position, 1, pause_option_size);
  
  player::lock(true);
  
  bool exit = false;
  
  do
  {
    
    switch(pause_menu.tick())
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      // Stats
      case 0:
        pause_menu.hide();
        open_stats();
        pause_menu.show();
        break;
      
      case 1:
        pause_menu.hide();
        open_inv();
        pause_menu.show();
        break;
    }
    
  } while(yield() && !exit);
  
  player::lock(false);
}


void open_stats()
{
  array<string> stats;
  
  stats.insertLast("HP:"  + formatInt(user_data::get_hp()));
  stats.insertLast("ATK:" + formatInt(user_data::get_atk()));
  stats.insertLast("DEF:" + formatInt(user_data::get_def()));
  
  list_menu stat_thing (stats, pause_menu_position, 1, pause_option_size);
  
  stat_thing.hide_cursor();
  
  bool exit = false;
  
  do
  {
    
    switch(stat_thing.tick())
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
    }
    
  } while(yield() && !exit);
}

void open_inv()
{
  array<string> inv_list = user_data::get_inventory_items();
  array<entity> inv_sprites(inv_list.length());
  
  for(uint i = 0; i < inv_sprites.length(); i++)
  {
    array<string> info = user_data::get_item_sprite(inv_list[i]);
    inv_sprites[i] = add_entity(info[0], info[1]);
  }
  
  list_menu inv ((inv_list.length() != 0 ? inv_list : array<string> = {"Empty", "Like", "Your", "Soul"}), pause_menu_position, 1, pause_option_size + pixel(26, 0));
  
  if(inv_list.length() == 0)
    inv.hide_cursor();
  
  bool exit = false;
  
  do
  {
    
    switch(inv.tick())
    {
      case menu_command::back:
        exit = true;
        break;
      
      case menu_command::nothing:
        break;
      
      default:
        //say descrioption or something
        break;
    }
    
  } while(yield() && !exit);
}

