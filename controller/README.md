# OPA400 controller

A motor controller capable of driving the four OPA400 motors:
- 2x Newport TRA25PPD Linear Motors
- 2x "Wright Group Style" Rotational motors

Uses 2 [Adafruit Stepper Motor Hats](https://www.adafruit.com/product/2348).

Uses one custom interrupt hat (see custom code below).

## Wright Group Rotational Motors

5 V drive, uses lower stepper motor hat.
Uses DB9 cable to connect to motor.

| index | identity   |
| ----- | ---------- |
| 1     |            |
| 2     | end of run |
| 3     | 5 V        |
| 4     | GND        |
| 5     |            |
| 6     | B2         |
| 7     | B1         |
| 8     | A1         |
| 9     | A2         |

## Newport TRA25PPD Linear Motors

12 V drive, uses upper stepper motor hat.

Uses DB25 cable to connect to motor.

| index | identity     |
| ----- | ------------ |
| 1     | A1           |
| 2     | A1           |
| 3     | A2           |
| 4     | A2           |
| 5     | B1           |
| 6     | B1           |
| 7     | B2           |
| 8     | B2           |
| 9     |              |
| 10    |              |
| 11    |              |
| 12    |              |
| 13    |              |
| 14    | GND          |
| 15    |              |
| 16    | GND          |
| 17    | + end of run |
| 18    | - end of run |
| 19    |              |
| 20    |              |
| 21    | 5 V          |
| 22    | GND          |
| 23    |              |
| 24    |              |
| 25    |              |