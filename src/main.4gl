#
# main.4gl  Main for all unit tests
#


import FGL fgldialog
import FGL test_color

private define
 m_menu boolean


#
# Main: Unit Test
#

main

  define
    p_test string

  let p_test = NVL(ARG_VAL(1), "color")
  call Run(p_test)
  
end main


#
#! Setup
#
private function Setup()

  if not m_menu
  then
    close window screen
  end if
  
end function


#
#! Teardown
#
private function Teardown()
end function


#
#! Menu
#
private function Menu()

  let m_menu = TRUE
  
  menu "Menu"
    on action color_input attribute(text="Color Input")
      call Run("color")
    on action color_array attribute(text="Color Array")
      call Run("color_array")
    on action close
      exit menu
  end menu
end function


#
#! Run
#
public function Run(p_request)

  define
    p_request string

  case p_request.toLowerCase()
    when "color"
      call Setup()
      call test_color.Test()
    when "color_array"
      call Setup()
      call test_color.Test_Array()
    when "menu"
      call Menu()
  end case
    
end function


