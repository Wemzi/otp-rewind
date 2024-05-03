# OTP Rewind 
![Screenshot 2024-05-03 at 19 11 23](https://github.com/Wemzi/otp-rewind/assets/55751876/84db03b2-a775-4762-834e-1636d3fc45aa) 

## What is it?
OTP Rewind is a complete application for Android and iOS, 
containing an Instagram-like story UI with AI and BigData filled data regarding the user's yearly financial data. 

## What does it do?
### Backend
The backend is storing the users, also supporting a basic authentication, in MongoDB. It contains pre-recorded data of
about ~1000 users, which is constantly processed in batches, with the help of the Spark framework. 
Upon the creation of the stories, there are automatically generated AI texts, dependant on the age of the user,
which gives tips on how to become more financially efficient.

### Frontend
This is then formatted intoJSON and provided to the frontend.
The frontend is mimicking the hungarian OTP Bank's application's UI, while nicely showing the data
provided by the backend.

## How to run it?
### Windows 
you will need Android Studio and Flutter installed. Please note that with this version you will only be able to use it with Android devices.

### macOS
You can develop for both platforms on macOS.
Android Studio, xCode, it's commandline tools, and an iOS simulator with a configured device is also necessary.

### Tool versions
You will find appropriate screen sizes to simulate these displays in the project settings.
Android Studio version: #AI-223.8836.35.2231.11005911.
The devices we used to test were an iPhone 13 and a Samsung Galaxy S21 Plus.
