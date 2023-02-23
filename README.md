## Docker - TheForest Dedicated Server

[![Build Status](https://drone.justmiles.io/api/badges/justmiles/the-forest/status.svg)](https://drone.justmiles.io/justmiles/the-forest)

## Environment Variables

| Environment Var               | Default Value     | Description                                                                                                                                   |
| ----------------------------- | ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `SERVER_IP`                   | `0.0.0.0`         | Server IP address - Note: If you have a router, this address is the internal address, and you need to configure ports forwarding              |
| `SERVER_STEAM_PORT`           | `8766`            | Steam Communication Port - Note: If you have a router you will need to open this port.                                                        |
| `SERVER_GAME_PORT`            | `27016`           | Game Communication Port - Note: If you have a router you will need to open this port.                                                         |
| `SERVER_QUERY_PORT`           | `27016`           | Game Communication Port - Note: If you have a router you will need to open this port.                                                         |
| `SERVER_NAME`                 | `the-forest`      | Server display name                                                                                                                           |
| `SERVER_PLAYERS`              | `8`               | Maximum number of players                                                                                                                     |
| `ENABLE_VAC`                  | `off`             | Enable VAC (Valve Anti-cheat System at the server. Must be set off or on                                                                      |
| `SERVER_PASSWORD`             | (blank)           | Server password. blank means no password                                                                                                      |
| `SERVER_PASSWORD_ADMIN`       | (blank)           | Server administration password. blank means no password                                                                                       |
| `SERVER_STEAM_ACCOUNT`        | (blank)           | Account token created from the [Steam Game Server Account Management](https://steamcommunity.com/dev/managegameservers) using app ID `242760` |
| `SERVER_AUTOSAVE_INTERVAL`    | `30`              | Time between server auto saves in minutes - The minumum time is 15 minutes, the default time is 30                                            |
| `DIFFICULTY`                  | `Normal`          | Game difficulty mode. Must be set to Peaceful Normal or Hard                                                                                  |
| `INIT_TYPE`                   | `Continue`        | New or continue a game. Must be set to New or Continue                                                                                        |
| `SLOT`                        | `1`               | Slot to save the game. Must be set 1 2 3 4 or 5                                                                                               |
| `SHOW_LOGS`                   | `off`             | Show event log. Must be set off or on                                                                                                         |
| `SERVER_CONTACT`              | `email@gmail.com` | Contact email for server admin                                                                                                                |
| `VEGAN_MODE`                  | `off`             | No enemies                                                                                                                                    |
| `VEGETARIAN_MODE`             | `off`             | No enemies during day time                                                                                                                    |
| `RESET_HOLES_MODE`            | `off`             | Reset all structure holes when loading a save                                                                                                 |
| `TREE_REGROW_MODE`            | `off`             | Regrow 10% of cut down trees when sleeping                                                                                                    |
| `ALLOW_BUILDING_DESTRUCTION`  | `on`              | Allow building destruction                                                                                                                    |
| `ALLOW_ENEMIES_CREATIVE_MODE` | `off`             | Allow enemies in creative games                                                                                                               |
| `ALLOW_CHEATS`                | `off`             | Allow clients to use the built in debug console                                                                                               |
| `REALISTIC_PLAYER_DAMAGE`     | `off`             | Use full weapon damage values when attacking other players                                                                                    |
| `TARGET_FPS_IDLE`             | `0`               | Target FPS when no client is connected                                                                                                        |
| `TARGET_FPS_ACTIVE`           | `0`               | Target FPS when there is at least one client connected                                                                                        |
| `UPDATE_SERVER`               | `false`           | Force a steam update of the game                                                                                                              |

## Volumes

- `/game` location of game server files
- `/savesMultiplayer` location of game saves

## Examples

Docker run:

```bash
docker run --rm \
  --name the-forest \
  -e SERVER_STEAM_ACCOUNT=XXXXXXXXXXXXX \
  -p 8766:8766/tcp \
  -p 8766:8766/udp \
  -p 27015:27015/tcp \
  -p 27015:27015/udp \
  -p 27016:27016/tcp \
  -p 27016:27016/udp \
  -v $PWD/game:/game \
  -v $PWD/saves:/savesMultiplayer \
  justmiles/the-forest:latest
```

Docker-Compose:

```yaml
version: "3.7"
services:
  the-forest:
    container_name: justmiles/the-forest
    image: justmiles/the-forest:latest
    restart: always
    environment:
      SERVER_STEAM_ACCOUNT: XXXXXXXXXXXXX
    ports:
      - 8766:8766/tcp
      - 8766:8766/udp
      - 27015:27015/tcp
      - 27015:27015/udp
      - 27016:27016/tcp
      - 27016:27016/udp
    volumes:
      - ./saves:/savesMultiplayer
      - ./game:/game
```
