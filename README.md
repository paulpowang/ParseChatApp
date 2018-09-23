# Lab 4 - *Name of App Here*

**Parse Chat** is a Chat app using an [open source Parse](http://parseplatform.org/) backend.

Time spent: **15** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User can sign up and sign in to the login screen (+1pt)
- [ ] User sees alerts for login exceptions, i.e. "account already exists", "wrong credentials", etc. (+1pt)
- [x] User can compose and send chat messages (+2pt)
- [x] User can view a list of chat messages in chronological order (+2pt)
- [ ] Automatically Adjust Cell Size to Fit Text (+1pt)
- [ ] Username of chat author is displayed in each chat message (+2pt)
- [x] Persist Logged in User (+1pt)

The following **stretch** user stories are implemented:

- [ ] User sees an activity indicator while waiting for authentication (+1pt)
- [ ] User can pull to refresh Chat feed (+1pt)
- [ ] Add an "Adorable Avatar" for each user by requesting an avatar from the [Adorable Avatars API](https://github.com/adorableio/avatars-api) (+2pt)
- [ ] Chat Bubble Style Design (+3pt)
- [ ] Expand or contract the cell layout as needed to show the chat message author (user) if it exists (+2pt)

The following **additional** user stories are implemented:

- [ ] List anything else that you can get done to improve the app functionality! (+1-3pts)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to get the auto layout right? especially for the UITableViewCell.
2. How to get the username from the database, since I can only see the id?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/paulpowang/ParseChatApp/blob/master/ParseChatApp_01.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes
The autolayout constain is kind of confusing, it is struggling to get the layout right. I spent a lot of time on this lab, but I still couldn't get all the require functions done.
The instuctions are not very clear to me, and also the xcode version differences. 
While I was working on this lab, I used a lot of online references and tutorials to help me more understand xcode function. However, there are few details are not clear to me. 
Anyway, I did got more familiar with parse function and JSON data while worked on this lab.


## License

Copyright [2018] [PoHung Wang]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
