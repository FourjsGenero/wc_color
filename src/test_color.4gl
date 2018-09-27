#
# test_color.4gl  Unit tests for wc_color
#

import FGL fgldialog
import FGL wc_color




#
#! Setup
#
private function Setup()  
    options input wrap
end function


#
#! Teardown
#
private function Teardown()
end function



#
#! Test Color Picker
#
public function Test()

  define
    p_alpha, p_beta, p_gamma, p_start, p_end string,
    p_color string


  call Setup()
  open window w_test with form "test_color"

  -- Define new Color picker
  let p_alpha = "red"
  let p_beta = "blue"
  let p_gamma = "green"
  
  -- Interact
  input p_start, p_alpha, p_beta, p_gamma, p_end
    from color_rec.*
    attributes(unbuffered, without defaults)
    
    on action zoom
      display dialog.getCurrentItem()
      let p_color = wc_color.DialogBox("Select Color", dialog.getFieldBuffer(dialog.getCurrentItem()))
      call dialog.setFieldValue(dialog.getCurrentItem(), p_color)
      
    on action red
      call dialog.setFieldValue(dialog.getCurrentItem(), "red")
      
    on action green
      call dialog.setFieldValue(dialog.getCurrentItem(), "green")
      
    on action blue
      call dialog.setFieldValue(dialog.getCurrentItem(), "blue")
      
  end input
  
  close window w_test
  call Teardown()
  
end function


#
#! Test Color Picker in Array
#
public function Test_Array()

  define
    a_rec dynamic array of record
      p_start, p_alpha, p_beta, p_gamma, p_end string
    end record,
    p_color string,
    i integer


  call Setup()
  open window w_test with form "test_color2"

  -- Initialize
  
  for i = 1 to 5
    let a_rec[i].p_alpha = "red"
    let a_rec[i].p_beta = "blue"
    let a_rec[i].p_gamma = "green"
  end for
  
  
  -- Interact
  input array a_rec from color_arr.*
    attributes(unbuffered, without defaults)

    on action zoom
      --%D: display dialog.getCurrentItem()
      let p_color = wc_color.DialogBox("Choose Color", dialog.getFieldBuffer(dialog.getCurrentItem()))
      call dialog.setFieldValue(dialog.getCurrentItem(), p_color)
      
    on action red
      call dialog.setFieldValue(dialog.getCurrentItem(), "red")
      
    on action green
      call dialog.setFieldValue(dialog.getCurrentItem(), "green")
      
    on action blue
      call dialog.setFieldValue(dialog.getCurrentItem(), "blue")
      
  end input
  
  close window w_test
  call Teardown()
  
end function