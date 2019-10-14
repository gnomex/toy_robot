# Toy Robot Simulator
    a robot simulator on RoR

## Description

* The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5x5. Having a CLI option and also a web version.

* There are no other obstructions on the table surface.

* The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

There is an application that can read in commands of the following form:

### Command Line Interface (CLI)

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

* `PLACE` will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

* The origin (0,0) can be considered to be the NORTH WEST most corner.

* The first valid command to the robot is a `PLACE` command, after that, any sequence of commands may be issued, in any order, including another `PLACE` command. The application should discard all commands in the sequence until a valid `PLACE` command has been executed

* `MOVE` will move the toy robot one unit forward in the direction it is currently facing.

* `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

* `REPORT` will announce the X,Y and F of the robot - Only in CLI version

* A robot that is not on the table can choose to ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.

* Inputs could be from a file or STDIN

* Provided test data at `lib/toy_robot/commands*.example`

#### Examples

From string `-c` argument using pipe `|` separator
```
./lib/toy_robot/cli.rb -c "PLACE 1,2,SOUTH|REPORT|MOVE|PLACE 1,2,SOUTH|MOVE|REPORT|RIGHT|LEFT|RIGHT|LEFT|MOVE|MOVE|REPORT"

./lib/toy_robot/cli.rb -c "PLACE 0,0,SOUTH|MOVE|REPORT|PLACE 0,0,SOUTH|LEFT|REPORT|PLACE 1,2,EAST|MOVE|MOVE|RIGHT|MOVE|REPORT"
```

From a file `-f`
```
./lib/toy_robot/cli.rb -f lib/toy_robot/commands.example
```

### WEB

* [Setup](./README.md#setup) first
* run `rails s`
* open `localhost:3000`
* have fun!

### Constraints

* The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.

* Any move that would cause the robot to fall must be ignored.

### Example Input and Output:

#### Example a

    PLACE 0,0,SOUTH
    MOVE
    REPORT

Expected output on CLI

    0,1,SOUTH

#### Example b

    PLACE 0,0,SOUTH
    LEFT
    REPORT

Expected output on CLI

    0,0,EAST

#### Example c

    PLACE 1,2,EAST
    MOVE
    MOVE
    RIGHT
    MOVE
    REPORT

Expected output on CLI

    3,3,SOUTH

## Setup

1. Make sure you have the Ruby 2.6.4 installed in your machine. If you need help installing Ruby, take a look at the [official installation guide](https://www.ruby-lang.org/en/documentation/installation/).

2. Install the [bundler](http://bundler.io/) and [rails](https://rubyonrails.org/) gems by running:

    ```gem install bundler```

3. Go to the a Rails app:

    ```cd toy_robot```

4. Install dependencies:

    ```bundle install```

5. Have Fun!

