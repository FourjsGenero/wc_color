"use strict";

// Options
var g_showFocus = true;      // show focus indicator or not
var g_focusBorderStyle = '3px solid #7FAFEB'; // Border CSS attributes

// State
var g_focus = true;           // if Widget has the focus or not


/*
** onClick: set focus to current field
*/
function onClick()
{
  //%D alert('onClick');
  gICAPI.SetFocus();
}

/*
** dblClick: Send zoom to notify DVM
*/
function dblClick()
{
  //%D alert('dblClick');
  gICAPI.SetFocus();
  gICAPI.Action('zoom');
}


/*
** onICHostReady: gICAPI interface
** @param {string} version
*/
var onICHostReady = function(p_version)
  {
  if (p_version != 1.0)
      alert('Invalid API version');

  // When the DVM set/remove the focus to/from the component
  gICAPI.onFocus = function(p_polarity)
    {
    if (p_polarity)
      {
      g_focus = true;
      if (g_showFocus)
        $('body').css('border', g_focusBorderStyle);
      }
    else
      {
      g_focus = false;
      if (g_showFocus)
        $('body').css('border', 'none');
      }
    }

  // When field data changes
  gICAPI.onData = function(p_value)
    {
    //%D: alert('onData: '+p_value);
    $('body').css('background-color', p_value);
    }

  // When the component property changes
  gICAPI.onProperty = function(p_property)
    {
    }

  // Initialize
  $('body').click(onClick);
  $('body').dblclick(dblClick);
  }



  
