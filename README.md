# NHL-STATS-APP
Disclaimer: This is my very first iOS swift app.
 - You can find the old code on the master branch
 - Atm I am refactoring this project with my skills I've gained over the years. You can find the partial refactor on develop. At this time it is mostly the "live" feed that is refactored.

This is a really basic app to follow the NHL games live, get info about the teams, see the ranking etc.

This was a school project, the goal was to make an app about something you like and the requirements where:
  - The app should use JSON (doesn't matter if it read or write JSON)
  - The app should at least have 3 screens
  - The app should have an appealing design (Totally forgot about this part 🤷‍♂️)
  
 I decided to make a simplified version of the NHL app. I am an NHL fan so I though this would be interesting. To get all the data needed to display live scores, the teams, players and rankings I used the NHL public api. The API isn't really documented so getting the right endpoints was quite tricky until I found this documentation by: @sidwarkd

https://www.kevinsidwar.com/iot/2017/7/1/the-undocumented-nhl-stats-api

This made everything a lot easier.


## ToDo:

- Introduce Unit tests (First finish Paul Hudson's Testting with Swift)
- Refactor all the massive view controllers
- Freshen up the design
- Maybe implement some CI/CD
- Implement the new api (https://gitlab.com/dword4/nhlapi)
  
## features
(If you can call them features)

### live feed
You can see the games that will be played today, where they will be played when the puckdrop is and their live scores.
The app can send notifications about the different plays that happend during the game, when tapping on them you get the whole live feed from the game and you can also see where on the ice the action happend.

The live feed actions give the following info: The player who made the action, the action itself, when it happend and the team.

### rankings
You can see the current ranking of the teams sorted by division, you can see the points they have, the loses and wins.

### teams
It is possible to see al the teams that are currently in the NHL, when selecting a team you can get more info about the team (the homeice, players, ranking etc.)

### players
The user can see the players from a team and get the info about them (birthplace, points, goals, position, ...)



