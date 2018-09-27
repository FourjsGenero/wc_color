import util

#
# color picker def
#
public type
  tRow dynamic array of string,
  tColorSelect record
    field string,
    showFocus boolean,
    doc record
      color string,
      flat boolean,
      showInput boolean,
      showPalette boolean,
      preferredFormat string,
      showButtons boolean,
      chooseText string,
      cancelText string,
      palette dynamic array of tRow
    end record
  end record

public define
  m_trace boolean


  
#
#! Init
#+ Initialize
#+
#+ @code
#+ call wc_c3chart.Init()
#
public function Init()

  let m_trace = FALSE
  
end function



#
#! Create
#+ Creates a new instance of Color
#+
#+ @param p_field     Form name of the field
#+ @returnType        tColorSelect
#+ @return            Color record
#+
#+ @code
#+ define r_acc wc_color.tColorSelect
#+ call wc_color.Create("formonly.p_color") returning r_color.*
#
public function Create(p_field string) returns tColorSelect

  define
    r_color tColorSelect


  -- Field name of widget
  let r_color.field = p_field

  -- Set defaults
  let r_color.showFocus = FALSE
  let r_color.doc.color = "#F00"
  let r_color.doc.flat = TRUE
  let r_color.doc.showInput = TRUE
  let r_color.doc.showPalette = TRUE
  let r_color.doc.preferredFormat = "hex"
  let r_color.doc.showButtons = FALSE
  let r_color.doc.chooseText = "Select"
  let r_color.doc.cancelText = "cancel"
            
  return r_color.*
  
end function



#
#! DialogBox      Color picker dialgbox in it's own window
#

public function DialogBox(p_title string, p_color string) returns string

  define
    r_color tColorSelect,
    p_colorselect string

  -- Define new Color picker
  call Create("formonly.p_colorselect")
    returning r_color.*

  -- Initialize
  let r_color.doc.color = p_color
  let p_colorselect = r_color.doc.color

  -- Load palette with default color set
  call Palette(r_color.*, "default")
  
  open window w_color with form "wc_color"
    attribute(style="dialog", text=p_title)

  -- Set widget
  call Set(r_color.*)
  
  -- Interact
  let p_colorselect = r_color.doc.color
  input by name p_colorselect 
    attributes(unbuffered, without defaults)
    on action select attribute(defaultview=no)
      message "color: " || p_colorselect
    on action cancel
      let p_colorselect = p_color
      exit input
  end input
  
  close window w_color

  return p_colorselect
  
end function



#
#! Domain
#+ Returns list of possible values in a domain
#+
#+ @param p_domain    Domain to return possible values of
#+
#+ @code
#+ define a_list dynamic array of string
#+ call wc_color.Domain("format") returning a_list
#

public function Domain(p_domain string) returns dynamic array of string

  define
    a_list dynamic array of string,
    i integer

  case p_domain.toUpperCase()
    when "FORMAT"
      let i = 0
      let a_list[i:=i+1] = ""
      let a_list[i:=i+1] = "hex"
      let a_list[i:=i+1] = "rgb"
      let a_list[i:=i+1] = "hsv"
  end case
  
  return a_list

end function


#
#!Html_Color
#
public function Html_Color(p_color string) returns string

  if p_color.getLength() < 1
  then
    let p_color = "#FFF"
  end if

  return '
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
  <head><meta name="qrichtext" content="1" /></head>
  <body style="background-color:' || p_color || ';color:black;margin:0;padding:0;">
  ' || p_color || '
  </body>
</html>
'
end function


#
#! Palette
#+ Set Palette to a preconfgured set of colors
#+
#+ @param r_color   tColorSelect
#+ @param p_set     Palette set
#+
#+ @code
#+ define r_color tColorSelect
#+ call wc_color.Palette(r_color.*, "default")
#
public function Palette(r_color tColorSelect, p_set string)

  define
    i integer
    
  case p_set.toLowerCase()
    when ""
    otherwise
      -- default set
      let i = 0
      call Row_Set('["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"]') returning r_color.doc.palette[i:=i+1]
      call Row_Set('["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]') returning r_color.doc.palette[i:=i+1]
  end case
  
end function



#
#! Row_Set
#+ Set tRow of data from JSONArray string
#+
#+ @param p_json    JSON array of strings
#+
#+ @code
#+ define p_json string, o_row tRow
#+ call wc_color.Row_Set('["#FF0","#0F0","#00F"]') returning o_row
#
public function Row_Set(p_json string) returns tRow

  define
    o_jArr util.JSONArray,
    a_row tRow

  let o_jArr = util.JSONArray.parse(p_json)
  call o_jArr.toFGL(a_row)
  
  return a_row
  
end function



#
#! Set
#+ Set initial contents of widget
#+
#+ @param r_color  Color instance
#+
#+ @code
#+ define r_color tColorSelect
#+ let r_color.color = "#F0A0B0"
#+ ...
#+ call wc_color.Set(r_color.*)
#
public function Set(r_color tColorSelect)

  call ui.Interface.frontCall("webcomponent", "call", [r_color.field, "Set", Serialize(r_color.*)], [])
  
end function



#
#! Serialize
#+ Serialize a color
#+
#+ @param r_color   tColorSelect
#+
#+ @returnType string
#+ @return JSON string of tColorSelect structure
#+
#+ @code
#+ define r_color wc_color.tColorSelect,
#+   p_json string
#+ let p_json = wc_color.Serialize(r_color.*)
#
public function Serialize(r_color tColorSelect) returns string

  call trace(util.JSON.stringify(r_color))
  return util.JSON.stringify(r_color)
  
end function




#
# PRIVATE
#

#
#! trace
#+ Dump argument string as trace to output if trace enabled
#+
#+ @param     Data string to dump to output
#+
#+ @code
#+ call trace('here i am')
#
private function trace(p_data string)

  if m_trace
  then
    display p_data
  end if

end function

