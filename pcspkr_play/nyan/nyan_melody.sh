#!/bin/bash

# Play nyancat melody on PC Speaker

hput () {
  eval hash"$1"='$2'
}

hget () {
  eval echo '${hash'"$1"'#hash}'
}

hput REST 1
hput NOTE_B0 31
hput NOTE_C1 33
hput NOTE_CS1 35
hput NOTE_D1 37
hput NOTE_DS1 39
hput NOTE_E1 41
hput NOTE_F1 44
hput NOTE_FS1 46
hput NOTE_G1 49
hput NOTE_GS1 52
hput NOTE_A1 55
hput NOTE_AS1 58
hput NOTE_B1 62
hput NOTE_C2 65
hput NOTE_CS2 69
hput NOTE_D2 73
hput NOTE_DS2 78
hput NOTE_E2 82
hput NOTE_F2 87
hput NOTE_FS2 93
hput NOTE_G2 98
hput NOTE_GS2 104
hput NOTE_A2 110
hput NOTE_AS2 117
hput NOTE_B2 123
hput NOTE_C3 131
hput NOTE_CS3 139
hput NOTE_D3 147
hput NOTE_DS3 156
hput NOTE_E3 165
hput NOTE_F3 175
hput NOTE_FS3 185
hput NOTE_G3 196
hput NOTE_GS3 208
hput NOTE_A3 220
hput NOTE_AS3 233
hput NOTE_B3 247
hput NOTE_C4 262
hput NOTE_CS4 277
hput NOTE_D4 294
hput NOTE_DS4 311
hput NOTE_E4 330
hput NOTE_F4 349
hput NOTE_FS4 370
hput NOTE_G4 392
hput NOTE_GS4 415
hput NOTE_A4 440
hput NOTE_AS4 466
hput NOTE_B4 494
hput NOTE_C5 523
hput NOTE_CS5 554
hput NOTE_D5 587
hput NOTE_DS5 622
hput NOTE_E5 659
hput NOTE_F5 698
hput NOTE_FS5 740
hput NOTE_G5 784
hput NOTE_GS5 831
hput NOTE_A5 880
hput NOTE_AS5 932
hput NOTE_B5 988
hput NOTE_C6 1047
hput NOTE_CS6 1109
hput NOTE_D6 1175
hput NOTE_DS6 1245
hput NOTE_E6 1319
hput NOTE_F6 1397
hput NOTE_FS6 1480
hput NOTE_G6 1568
hput NOTE_GS6 1661
hput NOTE_A6 1760
hput NOTE_AS6 1865
hput NOTE_B6 1976
hput NOTE_C7 2093
hput NOTE_CS7 2217
hput NOTE_D7 2349
hput NOTE_DS7 2489
hput NOTE_E7 2637
hput NOTE_F7 2794
hput NOTE_FS7 2960
hput NOTE_G7 3136
hput NOTE_GS7 3322
hput NOTE_A7 3520
hput NOTE_AS7 3729
hput NOTE_B7 3951
hput NOTE_C8 4186
hput NOTE_CS8 4435
hput NOTE_D8 4699
hput NOTE_DS8 4978

modprobe pcspkr
TEMPO=16

while read line
do 
  beep -f `hget ${line%% *}` -l $(( $(( 100 / ${line#* })) * $TEMPO ))
  sleep 0.01
done < "nyan_intro"

for i in {1..4}
do
  while read line
  do 
    beep -f `hget ${line%% *}` -l $(( $(( 100 / ${line#* })) * $TEMPO ))
    sleep 0.01
  done < "nyan_melody"
done

