# NHL-STATS-APP

This is a really basic app to follow the NHL games live, get info about the teams, see the ranking etc.

This was a school project, the goal was to make an app about something you like and the requirements where:
  - The app should use JSON (doesn't matter if it read or write JSON)
  - The app should at least have 3 screens
  - The app should have an appealing design (Totally forgot about this part 🤷‍♂️)
  
 I decided to make a simplified version of the NHL app. I am an NHL fan so I though this would be interesting. To get all the data needed to display live scores, the teams, players and rankings I used the NHL public api. The API isn't really documented so getting the right endpoints was quite tricky until I found this documentation by: sidwarkd

(https://www.kevinsidwar.com/iot/2017/7/1/the-undocumented-nhl-stats-api)

This made everything a lot easier.
  
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


## SOME SCREENSHOTS

![](NHL%20APP/screenshots/home.png)
![](NHL%20APP/screenshots/match.png)
![](NHL%20APP/screenshots/no-match.png)
![](NHL%20APP/screenshots/detail.png)
![](NHL%20APP/screenshots/teams.png)
![](NHL%20APP/screenshots/team.png)
![](NHL%20APP/screenshots/standins.png)



