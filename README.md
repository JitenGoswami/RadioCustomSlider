# RadioCustomSlider

Just add two files CustomSliderAM and CustomSliderFM from Custom Folder in your project.
You can review implementation of both custom sliders in viewcontroller.

Reason behind creating two different files for AM/FM is:
Generally, AM have frequency ranges from 500-1700. In most cases it also have a values in multiple of 10, so no need for decimal. 

While on other hand for FM have frequency ranges from 86.0-110.0. In FM frequency can be in decimal like 87.8, 92.8 etc. So to perform this task it should have each value as 0.1, 0.2 difference. In current custom class of FM it have a interval of 0.2.

You can add min, max and default values from ViewController. Also you can change a image of Pointer, font of labels, position, height and width of lines from respective Custom Classes.

When you scroll horizontally values will be updated in textfield and even if you want to move frequency to specific band then just add value in textfield and click on submit button.
