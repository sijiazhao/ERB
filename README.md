# ERB
Compute ERB power from sound files in MATLAB

This script uses ERB package (i.e. codes in the subfolder 'erb') written by Alain de Cheveigné (http://audition.ens.fr/adc/).

## How to use? 
1. Put your sound files (in .wav format) in the folder 'Sounds'. (By default, the folder contains five example sounds I made.)
2. Run 'computeERB.m'. 
3. You will get a figure saved as 'fig01_ERB.png' and a mat file including the variable 'ERB' listing all sound files' ERB values and 'condlist' listing the filenames of all sounds.
