"use strict";

// Options
var g_showFocus = false;      // show focus indicator or not
var g_focusBorderStyle = '3px solid #7FAFEB'; // Border CSS attributes

// State
var g_focus = false;          // if Widget has the focus or not
var g_data = '';              // Buffer to defer set data until focus



/*
** color_Select: Select a color, Send color back
** @param {string} Color
*/
function color_Select(p_color)
{
  // Focus needed to set data
  gICAPI.SetFocus();
  
  if (g_focus)
    data_Send(p_color, 'select');
  else
    g_data = p_color; //deferred until onFocus

  //%D:    alert('Select: '+p_color);
}


/*
** data_Send: Set data and Send action to notify DVM
** @param {string} Color
** @param {string} Action
*/
function data_Send(p_data, p_action)
{
  gICAPI.SetData(p_data);
  gICAPI.Action(p_action);
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

      // Used to send deferred Data when we have focus
      if (g_data)
        {
        data_Send(g_data, 'select');
        g_setData = '';
        }
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
    }

  // When the component property changes
  gICAPI.onProperty = function(p_property)
    {
    }
  }



  

//
//  PUBLIC //////////////////////////////
//

/*
** Set: Set contents of the widget specifed by JSON doc
*/
function Set(p_json)
{
  //%D: alert('Set: ' + p_json);
  
  // Reset: clear or hide everything  
  if (p_json)
    {
    // data defined, grab Color record
    var r_color = JSON.parse(p_json);

    // Set options
    if (r_color.showFocus)
      g_showFocus = true;

    // Add move event 
    r_color.doc.move = function(color) {color_Select(color.toHexString())};
    
    // Fire up color picker
    $('#spectrum').spectrum(r_color.doc);
    }
}






