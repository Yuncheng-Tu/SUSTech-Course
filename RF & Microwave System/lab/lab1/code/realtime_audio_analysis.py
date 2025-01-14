# -*- coding: utf-8 -*-
# Real-time Doppler speed calculation and display 
# using the computer sound card as input
# 
#originally written by Meng Wei, a summer exchange student (UCD GREAT Program, 2013) from Zhejiang University, China
#modified by Xiaoguang Liu (lxgliu@ucdavis.edu) Sept 2015
#
#To Do:
# - Add GUI guide for selecting the sound input device
# - 

import pyaudio
import numpy as np
from matplotlib import pyplot as plt
from struct import unpack
from matplotlib.widgets import Button

def fftlogmag(data):
    '''
    compute log magnitude of the fft of data
    '''
    o=20*np.log10(np.absolute(np.fft.fft(data))+1e-10)  #add a small number 1e-10 to avoid divide by zero
    
	#only the first half in each row contains unique information
    return o[:int(len(o)/2)]

CHUNK = 2048		#length of each data block; also the FFT size
FORMAT = pyaudio.paInt16     #16-bit

#if your sound input device has only 1 channel, you need to assign 1 to "CHANNELS"
CHANNELS = 1
RATE = 44100

s=np.zeros(CHUNK)
v=s

f_max = RATE/2

#set up display
#create figure
fig=plt.figure()

#time domain signal plot
ax1 = fig.add_subplot(2,1,1)
lines_time = ax1.plot(s)
plt.xlim([0, int(CHUNK)])
t=range(0,9)     #8 major ticks
xticks=[x*CHUNK/8 for x in t]
ax1.set_xticks(xticks)

#frequency domain signal display
ax2 = fig.add_subplot(2,1,2)
lines_freq=ax2.plot(v,'b')

plt.xlim([0, int(CHUNK/2)])
t=range(0,9)     #8 major ticks
xticks=[x*CHUNK/16 for x in t]

#scale the tick labels to the proper speed
xtick_labels=[str(int(x*f_max/8)) for x in t]
ax2.set_xticks(xticks)
ax2.set_xticklabels(xtick_labels)

plt.xlabel('Frequency (Hz)',{'fontsize':12})
plt.ylabel('time [s]',{'fontsize':12})

#add a stop button
#press the stop button to stop the program
STOP = False
def Stop(event):
    global STOP 
    STOP = not STOP

ax_stop = fig.add_axes([0.8, 0.01, 0.1, 0.05])
bn_stop = Button(ax_stop, 'Stop', color='0.65')
bn_stop.on_clicked(Stop)

plt.ion()
plt.show()

#set up audio input
p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True,
                frames_per_buffer=CHUNK)

while not STOP:
    lines_time.pop(0).remove()
    #psd_lines.pop(0).remove()
    lines_freq.pop(0).remove()
    
    sample = stream.read(CHUNK)
    
    for i in range(0,CHUNK):
        if CHANNELS == 1:
		data = sample[2*i:2*i+2]
        elif CHANNELS == 2:
		#get the right channel
		data = sample[4*i+2:4*i+4]
        #the sound level information is stored in signed 16-bit integers in little-endian format
        #The "struct" module provides functions to convert such information to python native formats, in this case, integers.
        u = unpack('h', data)[0]            
        #normalize the value to 1 and store them in a two dimensional array "s"        
        s[i]=u/32768.0
    
    v=fftlogmag(s)
  
    lines_time=ax1.plot(s,'b')     #time domain signal plot
    lines_freq=ax2.plot(v,'b')     #frequency domain signal plot
    
    plt.draw()
    plt.pause(0.01)
