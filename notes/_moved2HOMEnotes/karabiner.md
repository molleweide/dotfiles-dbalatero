# KARABINER

# karabiner build from source

create two test clones

depth 1
recursive all

## ??
    cli refresh/remove complex rules
        goal -> gulp automatic build flow
        otherwise it still takes quite a lot of time 
        to test small nuances of karabiner. or at least
        the process could be much faster which would
        be nice.


# LAPTOP LAYERS
karabiner layers
1. molleweide modrows
2. standard layout
3. turn off all keys.
only keep layer turn on button
4. midi keys.
       - turn off modrows
       - RK enter virtual midi layer

# qmk-lib.rb
create a func lib where I implement all the functions
I know from qmk. This could be a really nice addition two
karabiner.



============================================

create function to run these two commands
in zsh easilly

how do I wait for the make command to finish and then cp?
wait, that is how it always work

krmcp = function run below


```shell
# compile json
make
```

```shell
move file to karabiner config
cp public/json/your_awesome_configuration.json ~/.config/karabiner/assets/complex_modifications
```


how do I make layers w karabiner??
hold down space bar enter move layer?


use regular fn keys
