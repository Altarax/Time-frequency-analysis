# Time-frequency-analysis
I had to do a school project to do a time frequency analysis on audio and chirp signal.
This project allows us (if you finish it, and i finished it) to do a Time-Frequency Analysis
for evolutionary signals.

/!\ All my comments are not necessarily in english /!\

For this project and all projects, it was obliged to create a demo version (with a chirp signal)
and a project version (with an audio file).

# Steps

## (demo version) : First I had to create a chirp signal :

![image](https://user-images.githubusercontent.com/46035021/123969787-d70b8b80-d9b8-11eb-8f99-7d42b6d5550e.png)

> To do the analysis, we needed to create an hamming window and shift this window.

![image](https://user-images.githubusercontent.com/46035021/123970045-13d78280-d9b9-11eb-81ae-b4cedfa0b03d.png)

> It's important to make a matrix filled by the multiplication of hamming vector and our initial signal.
Finally, this matrix can be dislayed with the imagesc command.

![image](https://user-images.githubusercontent.com/46035021/123970536-7a5ca080-d9b9-11eb-8e7e-a572a0b3c61d.png)

## (project version) For this version, I created a complete GUI (audio.m) :

![image](https://user-images.githubusercontent.com/46035021/123970894-d3c4cf80-d9b9-11eb-8946-90f24de67bcc.png)

> It was important for the project version to let the user to fill intervals to reduce the initial signal.  
> The initial signal is received by using my function get_audio_signal and the function audioread.  
> Finally, the user had to be able to fill the length of hamming window and the length of the increment.

![image](https://user-images.githubusercontent.com/46035021/123972359-10dd9180-d9bb-11eb-9933-e416658a3e0f.png)

> It's important to make a matrix filled by the multiplication of hamming vector and our initial signal.  
> Finally, this matrix can be dislayed with the imagesc command.

![image](https://user-images.githubusercontent.com/46035021/123972430-20f57100-d9bb-11eb-8c9e-734acbad554b.png)

## Me and programming langages (progression)
- *30/06/2021* 

| VHDL                        | Python                      | C                           |
|-----------------------------|-----------------------------|-----------------------------|
|  ➖➖➖🚀➖➖➖➖➖🌑  |  ➖➖➖➖➖➖🚀➖➖🌑  |  ➖➖➖➖➖🚀➖➖➖🌑  |
