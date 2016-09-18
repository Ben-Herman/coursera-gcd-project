# HAR Data Extract Codebook

## Categorical data

__activity__: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING

__subject__: Integer identifying the subject

__usage__: How the data was used.  TRAINING or TESTING

## Feature names

Feature names are composed from different combinations of string pieces as shown:

__\[t|f\]\[body|gravity\]\[acc|gyro\]\[|jerk\]\[|mag\]\[mean|std\]\[|x|y|z\]__

### \[t|f\]
Is the feature from the time domain or fourier transform signal?

### \[body|gravity\]
Did the feature come from a body or gravity signal?

### \[acc|gyro\]
Did the feature come from the accelerometer of gyroscope?

### \[|jerk\]
Did the feature come from a regular (empty string piece) or jerk signal?

### \[|mag\]
Axis (empty string piece) or magnitude feature

### \[mean|std\]
Mean or standard deviation feature

### \[|x|y|z\]
x, y, or z axis.  (empty string piece if magnitude) 

## Units
As indicated by the data authors, "Features are normalized and bounded within \[\-1,1\]",
therefore feature units are arbitrary.
